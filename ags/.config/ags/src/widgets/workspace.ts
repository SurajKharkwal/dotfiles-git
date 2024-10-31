import { WorkspaceBtn } from "./utils/helper";

const WorkSpace = await Service.import("hyprland");
const { Box } = Widget;

const activeIcon = "";

const createWidget = () => {
  const activeId = WorkSpace.active.workspace.id;
  return Array.from({ length: 10 }, (_, i) => {
    const workspaceId = i + 1;
    if (WorkSpace.workspaces.some(ele => ele.id === workspaceId)) {
      return activeId === workspaceId
        ? WorkspaceBtn(activeIcon, "active", workspaceId)
        : WorkspaceBtn(`${workspaceId}`, "has-window", workspaceId);
    }
    return WorkspaceBtn(`${workspaceId}`, "empty", workspaceId);
  });
};

export const workspace = Box({
  children: createWidget(),
  setup: self => self.hook(WorkSpace, () => (self.children = createWidget()))
});
