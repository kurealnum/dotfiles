---
name: cache-codebase
description: Caches a codebase to reduce token usage
---

# Caching a codebase

Reduce token usage by reading off a minimized version of a given codebase.

This is to be used for browsing the codebase. When a file needs to be modified, do not read the cache. Read the file directly instead. When a file is updated, the cache should be updated (if necessary).

## When to activate

- The user says "cache codebase"
- The user says "read from cache"
- A large file needs to be read

## Caching

### Cache structure

The cache should be stored on disk in the codebase itself as an exact replica of the codebase, stored in the folder `.cached-codebase` in the root directory. Every relevant file (see next) in the codebase should be cached as a markdown file with a short description, which is described further in this document.

DO NOT cache files and files in folders such as:

- `node_modules/`
- Any files or folders in `.gitignore`

The `.cached-codebase` folder may be in `.gitignore` - this is ok.

#### Example

Given the following codebase:

```
.
├── ui.js
└── lib/
    ├── formatter.js
    └── renderer.ts
```

The codebase should look like this after being cached:

```
.
├── ui.js
├── lib/
│   ├── formatter.js
│   └── renderer.ts
└── .cached-codebase/
    ├── ui.md
    └── lib/
        ├── formatter.md
        └── renderer.md
```

### Caching a file

This is the template that should be used for caching a file.

```md
---
last-cached: Mon Apr 13 10:50:58 EDT 2026
description: A one sentence summary of the file. Include the purpose of the file and what it does.
quirks: Weird things about this file - functionality that isn't standard, anything that would affect development if it wasn't mentioned. Keep this to a maximum of two sentences
linked-to: Does this file use any special or weird imports? Is it used in any odd files?
---
```

#### Explanations of fields

- `last-cached`: should be retrieved with the `date` command.
- `description`: a general description of the file. If this file is a standard file, denote it as such (ex. `actions.ts` or `page.tsx`). Include any notable/exported functions
- `quirks`: weird things about this file that weren't included in the description
- `linked-to`: weird imports that the file uses, and weird exports that the file has. For example, ShadCN, Lucide, and imports from `lib` do **not** count as weird imports. Imports such as `dnd-kit` or other not-widely used imports _do_ count as weird imports.

## Reading the cache

When a file needs to be read, first check the cache. Interpret the markdown file, _then_ modify the file if needed.

The entire goal of this cache is to minimize the amount of tokens that need to spent reading unnecessary files.

If you need to understand a certain part of the code, you may read the real file.

## When to avoid the cache

Avoid the cache when:

- Modifying a file
- Inspecting specific code (ex. there's a bug in a server action)

## When to use the cache

Use the cache when:

- Understanding the codebase
- Tracing a bug
- Any time you don't need to inspect each and every line of a file

## Updating the cache

Updating the cache should look like this:

1. Update the date modified
2. Reread the real file and update all other fields
