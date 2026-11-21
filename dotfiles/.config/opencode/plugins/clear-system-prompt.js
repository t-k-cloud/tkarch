export default async () => ({
  "experimental.chat.system.transform": async ({ model }, output) => {
    if (/gemini|claude/i.test(model.id)) {
      output.system.length = 0
    }
  },
})
