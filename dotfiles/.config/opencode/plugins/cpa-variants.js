const EFFORTS = [
  [/claude|opus|sonnet|fable/i, ["low", "medium", "high", "xhigh", "max"]],
  [/gpt/i, ["none", "low", "medium", "high", "xhigh"]],
  [/gemini/i, ["low", "medium", "high"]],
  [/deepseek/i, ["low", "medium", "high", "max"]],
]

export default async () => ({
  config: async (config) => {
    const models = config.provider?.CPAProvider?.models ?? {}
    for (const [id, model] of Object.entries(models)) {
      const efforts = EFFORTS.find(([pattern]) => pattern.test(id))
      if (efforts && !model.variants) {
        model.variants = Object.fromEntries(
          efforts[1].map((effort) => [effort, { reasoningEffort: effort }]),
        )
      }
    }
  },
})
