# JD Lib
My custom-made library for notifications in FiveM, I am still adding to this project, so don't expect a lot at the moment.

## **Open Source, but do not re-publish or sell**

---

## Using jd_lib as a Dependency

### 1. Declare the dependency in your resource's `fxmanifest.lua`
```lua
dependencies {
    'jd_lib',
}
```
FiveM will ensure `jd_lib` starts before your resource.

### 2. Import the lib table at the top of your client script

```lua
local lib = exports['jd_lib']:getLib()
```

### 3. Use it
```lua
lib.notify({
    title       = 'Hello',
    description = 'jd_lib is working!',
    type        = 'success',
    duration    = 4000,
})
```

---

## Notification Parameters

```
lib.notify(options)

@param options.title       string  – Notification title
@param options.description string  – Body text (optional)
@param options.type        string  – 'success' | 'error' | 'warning' | 'info'
@param options.duration    number  – Duration in ms (default 4000)
@param options.position    string  – 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left' (default 'top-right')
```

### Examples

```lua
-- Success
lib.notify({ title = 'Saved', description = 'Data was saved.', type = 'success' })

-- Error
lib.notify({ title = 'Failed', description = 'Something went wrong.', type = 'error', duration = 5000 })

-- Warning
lib.notify({ title = 'Caution', description = 'Irreversible action.', type = 'warning' })

-- Info
lib.notify({ title = 'FYI', description = 'jd_lib is active.', type = 'info' })
```

### New possitions available for the notifications (add to bottom of you notify under duration in the provided format)
```lua
possition = top-left,
possition = top-right, (deafult)
possition = top-center,
```

---
v1.1 — 17/04/2026 (release date)
