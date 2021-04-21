export const dbg = (msg: string): void => {
  if (
    process.env.DEBUG_ROC_SERVER !== undefined &&
    Number(process.env.DEBUG_ROC_SERVER) > 0
  ) {
    console.log(msg);
  }
};

export const promiseWithTimeout = (
  timeoutMs: number,
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  promise: Promise<any>
) => {
  let timeoutHandle: NodeJS.Timeout;
  const timeoutPromise = new Promise((_resolve, reject) => {
    timeoutHandle = setTimeout(() => reject(), timeoutMs);
  });

  return Promise.race([promise, timeoutPromise]).then(result => {
    clearTimeout(timeoutHandle);
    return result;
  });
};
