import { Labels } from "./utils/helper";

const Battery = await Service.import("battery");

const icons = {
  100: "󰁹",
  75: "󰂁",
  50: "󰁾",
  25: "󰁻",
  0: "󰂎",
  "-1": "󱟢", // AC power icon
};

const { Box } = Widget;

const getIcons = (per: number) => {
  if (per === -1) return icons["-1"];
  const roundedPer = Math.floor(per / 25) * 25;
  return icons[roundedPer]
};

const getState = () => (!Battery.charging ? "un-plugged" : "charging");

export const battery = Box({
  children: [
    Labels(`${Battery.percent === -1 ? 100 : Battery.percent}%`, "battery-label"),
    Labels(getIcons(Battery.percent), getState()),
  ],
  setup: (self) =>
    self.hook(Battery, (box) => {
      box.children = [
        Labels(`${Battery.percent === -1 ? 100 : Battery.percent}%`, "battery-label"),
        Labels(getIcons(Battery.percent), getState()),
      ];
    })
});
