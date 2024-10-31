import { Labels } from "./utils/helper";

const { Box } = Widget;

function getTime() {
  const date = new Date();
  const timeFormatter = new Intl.DateTimeFormat("en-US", {
    hour: "2-digit",
    minute: "2-digit",
    hour12: true,
  });
  return timeFormatter.format(date).toUpperCase();
}

function getDate() {
  const date = new Date();
  const dayFormatter = new Intl.DateTimeFormat("en-US", { weekday: "long" });
  const dayOfWeek = dayFormatter.format(date);

  const dateFormatter = new Intl.DateTimeFormat("en-GB", {
    day: "2-digit",
    month: "2-digit",
  });
  const dateFormatted = dateFormatter.format(date);

  return `${dayOfWeek} ${dateFormatted}`;
}

const Time = Variable("", {
  poll: [1000, () => getTime()]
});

const CurrentDate = Variable("", {
  poll: [1000, () => getDate()]
});

export const time = Box({
  children: [
    Labels(Time.value, "time"),
    Labels("", 'dot'),
    Labels(CurrentDate.value, "date"),
  ],
  setup: (self) => {
    self.hook(Time, () => {
      self.children = [
        Labels(Time.value, "time"),
        Labels("", 'dot'),
        Labels(CurrentDate.value, "date"),
      ];
    });
  },
});
