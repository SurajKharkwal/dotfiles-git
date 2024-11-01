const { Label, Box, Button } = Widget

export const Labels = (label: string, className: string = "") => Label({
  label,
  className
})

export const WorkspaceBtn = (label: string, className: string, id: number) => Button({
  className: `${className}-btn`, child: Labels(label, `${className}-label`),
  onClicked: () => Utils.execAsync(['bash', '-c', `hyprctl dispatch workspace ${id} `])

})

export const formatSentence = (sen: string, len: number) => sen.slice(0, len)
