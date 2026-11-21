export default async () => ({
  "experimental.chat.system.transform": async ({ model }, output) => {
    if (/(?:^|\/)gemini(?:-|$)/i.test(model.id)) {
      output.system.length = 0
    }
  },
})
