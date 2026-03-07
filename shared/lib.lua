-- ╔══════════════════════════════════════════════╗
-- ║             JD Library  ·  Shared           ║
-- ║    require this from other resources via:   ║
-- ║      local lib = exports['jd_lib']:lib()   ║
-- ╚══════════════════════════════════════════════╝

---@class JDLib
lib = {}

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
function lib.notify(options)
    -- validate
    assert(type(options) == 'table',  '[jd_lib] lib.notify expects a table')
    assert(type(options.title) == 'string' or type(options.description) == 'string',
        '[jd_lib] lib.notify requires at least a title or description')

    SendNUIMessage({
        action      = 'notify',
        title       = options.title or '',
        description = options.description or '',
        type        = options.type or 'info',
        duration    = options.duration or 4000,
        position    = options.position or 'top-right',
    })
end
