# JD Lib
My custom-made library for notifications in FiveM, I am still adding to this project, so don't expect alot at the moment.

## **Open Source, but do not re-publish or sell**

These are the parameters for the script
```
lib.notify(options)

@param options.title       string    – Notification title
@param options.description string    – Body text (optional)
@param options.type        string    – 'success' | 'error' | 'warning' | 'info'
@param options.duration    number    – Duration in ms (default 4000)
@param options.position   string    – 'top-right'|'top-left'|'bottom-right'|'bottom-left' (default 'top-right')

Example:
lib.notify({ title = 'Saved', description = 'Data was saved.', type = 'success' })
```

**JD lib Notification Useage**

```
Use this for a success notification

lib.notify({
    title       = 'TITLE',
    description = 'DESCRIPTION',
    type        = 'success',
    duration    = 6000,
})

Use this for a error notification

lib.notify({
    title       = 'TITLE',
    description = 'DESCRIPTION',
    type        = 'error',
    duration    = 6000,
})

Use this for a warning notification

lib.notify({
    title       = 'TITLE',
    description = 'DESCRIPTION',
    type        = 'warning',
    duration    = 6000,
})

Use this for a info notification

lib.notify({
    title       = 'TITLE',
    description = 'DESCRIPTION',
    type        = 'info',
    duration    = 6000,
})
```
