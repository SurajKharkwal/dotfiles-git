import { battery } from "src/widgets/battery"
import { Media } from "src/widgets/Player"
import { time } from "src/widgets/time"
import { workspace } from "src/widgets/workspace"

const { Box, CenterBox } = Widget


const Bar = (monitor: number) => Widget.Window({
  name: `bar-${monitor}`,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'ignore',
  child: CenterBox({

    centerWidget: CenterBox({
      startWidget: time,
      centerWidget: workspace
    }),
    endWidget: Box({
      hpack: 'end',
      children: [
        battery,
      ]
    })
  })
})

const Player = (monitor: number) => Widget.Window({
  name: `player-${monitor}`,
  anchor: ['top', 'left',],
  exclusivity: 'ignore',
  child: Media()
})



const css = App.configDir + "/src/styles/main.css"

App.config({
  style: css,
  windows: [Bar(0), Player(0)]
})
