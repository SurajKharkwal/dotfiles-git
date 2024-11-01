import { selection_owner_get_for_display } from "types/@girs/gdk-3.0/gdk-3.0.cjs"
import { style_tag_t } from "types/@girs/harfbuzz-0.0/harfbuzz-0.0.cjs"
import { MprisPlayer } from "types/service/mpris"

const mpris = await Service.import("mpris")
const players = mpris.bind("players")

const FALLBACK_ICON = "audio-x-generic-symbolic"
const PLAY_ICON = "media-playback-start-symbolic"
const PAUSE_ICON = "media-playback-pause-symbolic"
const PREV_ICON = "media-skip-backward-symbolic"
const NEXT_ICON = "media-skip-forward-symbolic"

function lengthStr(length: number): string {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);

  // Ensure both minutes and seconds are always two digits
  const minFormatted = min < 10 ? `0${min}` : `${min}`;
  const secFormatted = sec < 10 ? `0${sec}` : `${sec}`;

  return `${minFormatted}:${secFormatted}`;
}
function Player(player: MprisPlayer) {
  const img = Widget.Box({
    class_name: "img",
    vpack: "start",
    css: player.bind("cover_path").transform(p => `
            background-image: url('${p}');
        `),
  })

  const title = Widget.Label({
    class_name: "title",
    wrap: true,
    hpack: "start",
    label: (player.bind("track_title").transform(a => a == "" ? "No Track Title Found" : a))
  })

  const artist = Widget.Label({
    class_name: "artist",
    wrap: true,
    hpack: "start",
    label: player.bind("track_artists").transform(a => a.join(", ")),
  })

  const positionSlider = Widget.Slider({
    class_name: "position",
    draw_value: false,
    on_change: ({ value }) => player.position = value * player.length,
    visible: player.bind("length").as(l => l > 0),
    setup: self => {
      function update() {
        const value = player.position / player.length
        self.value = value > 0 ? value : 0
      }
      self.hook(player, update)
      self.hook(player, update, "position")
      self.poll(1000, update)
    },
  })
  const addOneSecond = (time: string) => {
    let [h, m] = time.split(':').map(Number);
    m += 1;
    if (m === 60) { m = 0; h += 1; }
    if (h === 24) h = 0;
    return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
  };

  const positionLabel = Widget.Label({
    class_name: "position",
    hpack: "start",
    label: lengthStr(player.position),
    setup: self => self.poll(1000, (lbl) => {

      lbl.label = addOneSecond(lbl.label)
    })
  })
  const lengthLabel = Widget.Label({
    class_name: "length",
    hpack: "end",
    visible: player.bind("length").transform(l => l > 0),
    label: player.bind("length").transform(lengthStr),

  })

  const icon = Widget.Icon({
    class_name: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
    tooltip_text: player.identity || "",
    icon: player.bind("entry").transform(entry => {
      const name = `${entry}-symbolic`
      return Utils.lookUpIcon(name) ? name : FALLBACK_ICON
    }),
  })

  const playPause = Widget.Button({
    class_name: "play-pause",
    on_clicked: () => player.playPause(),
    className: player.bind("can_play") ? "diabled-btn" : "player-btn",
    child: Widget.Icon({
      icon: player.bind("play_back_status").transform(s => {
        switch (s) {
          case "Playing": return PAUSE_ICON
          case "Paused":
          case "Stopped": return PLAY_ICON
        }
      }),
    }),
  })

  const prev = Widget.Button({
    on_clicked: () => player.previous(),
    className: player.bind("can_go_prev") ? "diabled-btn" : "player-btn",
    child: Widget.Icon(PREV_ICON),
  })

  const next = Widget.Button({
    on_clicked: () => player.next(),
    className: player.bind("can_go_next") ? "diabled-btn" : "player-btn",
    child: Widget.Icon(NEXT_ICON),
  })

  return Widget.Box(
    { class_name: "player" },
    img,
    Widget.Box(
      {
        vertical: true,
        hexpand: true,
      },
      Widget.Box([
        title,
        icon,
      ]),
      artist,
      Widget.Box({ vexpand: true }),
      positionSlider,
      Widget.CenterBox({
        start_widget: positionLabel,
        center_widget: Widget.Box([
          prev,
          playPause,
          next,
        ]),
        end_widget: lengthLabel,
      }),
    ),
  )
}

export function Media() {
  return Widget.Box({
    vertical: true,
    css: "min-height: 2px; min-width: 2px;", // small hack to make it visible
    visible: players.as(p => p.length > 0),
    children: players.as(p => p.map(Player)),
  })
}
