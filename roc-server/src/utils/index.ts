export const dbg = (msg: string): void => {
  if (
    process.env.DEBUG_ROC_SERVER !== undefined &&
    Number(process.env.DEBUG_ROC_SERVER) > 0
  ) {
    console.log(msg);
  }
};
