# JD Lib
My custom-made library for notifications in FiveM, I am still adding to this project, so don't expect alot at the moment.

## **Open Source, but do not re-publish or sell**

These are the parameters for the script for external usage
```
--[[
    lib.notify(options)

    @param options.title       string    – Notification title
    @param options.description string    – Body text (optional)
    @param options.type        string    – 'success' | 'error' | 'warning' | 'info'
    @param options.duration    number    – Duration in ms (default 4000)
    @param options.position   string    – 'top-right'|'top-left'|'bottom-right'|'bottom-left' (default 'top-right')

    Example:
        lib.notify({ title = 'Saved', description = 'Data was saved.', type = 'success' })
]]
```

**Fxmanifest Example for external scripts**
``` 
fx_version 'cerulean'
game { 'gta5' }

dependency {
'jd-lib'
}
```

**JD lib public exports**

```
**Use this for a success notification**
exports['jd_lib']:notify({
    title = 'Wanted Level Cleared', 
    type  = 'success',
})

**Use this for a error notification**
exports['jd_lib']:notify({
    title = 'Wanted Level Cleared', 
    type  = 'error',
})

**Use this for a warning notification**
exports['jd_lib']:notify({
    title = 'Wanted Level Cleared', 
    type  = 'warning',
})

**Use this for a info notification**
exports['jd_lib']:notify({
    title = 'Wanted Level Cleared', 
    type  = 'info',
})
```
