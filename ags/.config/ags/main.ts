import { battery } from "src/widgets/battery"

const { Box, CenterBox } = Widget


const Bar = (monitor: number) => Widget.Window({
  name: `bar-${monitor}`,
  anchor: ['top', 'left', 'right'],
  child: CenterBox({
    endWidget: Box({
      children: [
        battery
      ]
    })
  })
})

App.config({
  windows: [Bar(0)]
})
