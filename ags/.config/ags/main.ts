import { battery } from "src/widgets/battery"
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
        battery
      ]
    })
  })
})

App.config({
  windows: [Bar(0)]
})
