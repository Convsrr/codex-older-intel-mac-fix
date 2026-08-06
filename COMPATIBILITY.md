# Compatibility results

This table records tests reported for older Intel Macs after the ChatGPT/Codex desktop update.

## Confirmed tests

| Mac | Architecture | macOS | Build tested | Result | Source |
|---|---|---|---|---|---|
| MacBook Air (2017) | Intel x64 | Monterey 12.7.6 | Legacy build 26.721.81911 | Working | Personally tested by repository owner |
| MacBook Air (2017) | Intel x64 | Monterey 12.7.6 | Build 26.727.51351 | Failed to open; macOS compatibility error | Personally tested by repository owner |

## How to report a result

Open a **Compatibility report** issue and include:

- Mac model and year
- Model identifier, when available
- Intel or Apple Silicon
- macOS version
- Application version tested
- Whether the app opened
- Whether sign-in and basic Codex functionality worked
- Any exact error message

Do not include passwords, login codes, cookies, API keys, tokens, repository secrets or private project data.

## What a result means

A working result confirms only that the specified build opened and was usable in that reported environment at the time of testing. It does not guarantee future server compatibility, security support or availability.

The complete recovery process and researched download links are available in the [rollback guide](https://convsrr.gumroad.com/l/codex-older-mac-fix).