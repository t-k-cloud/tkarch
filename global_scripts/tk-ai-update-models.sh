#!/usr/bin/env bash
set -eu

config="$HOME/.config/opencode/opencode.json"
models=${1:?Usage: tk-ai-update-models.sh MODELS_DIRECTORY
Example: tk-ai-update-models.sh ~/Desktop/highclaws-core/secrets/models/}

jq --slurpfile catalog "$models/highclaws.json" \
   --slurpfile contexts "$models/context.json" \
   --slurpfile prices "$models/pricing.json" '
    def model_cost($id):
        $prices[0]["highclaws/" + $id] |
        {input: (.input_price // error("\($id): missing input price")),
         output: (.output_price // error("\($id): missing output price")),
         cache_read: .cache_read_price, cache_write: .cache_write_price} |
        del(.[] | nulls);

    .provider.CPAProvider.models as $previous |
    .provider.CPAProvider.models = (
        reduce ($catalog[0] | keys[]) as $id ({};
            .[$id] = ($previous[$id]
                | .name = "\($id) (CPA)"
                | .reasoning = true
                | .modalities = {input: ["text", "image"], output: ["text"]}
                | .cost = model_cost($id)
                | .limit = {
                    context: ($contexts[0].highclaws[$id] // error("\($id): missing context window")),
                    output: 32768
                })
        )
    )
' "$config" > "$config.tmp"

# Write through the dotfiles symlink.
cat "$config.tmp" > "$config"
rm "$config.tmp"
