-- ╔══════════════════════════════════════════════╗
-- ║        JD Library  ·  Test Commands         ║
-- ╚══════════════════════════════════════════════╝

-- /success
RegisterCommand('success', function()
    lib.notify({
        title       = 'Action Completed',
        description = 'Everything went through without a problem.',
        type        = 'success',
        duration    = 4000,
    })
end, false)

-- /error
RegisterCommand('error', function()
    lib.notify({
        title       = 'Something Went Wrong',
        description = 'The operation could not be completed.',
        type        = 'error',
        duration    = 5000,
    })
end, false)

-- /warning
RegisterCommand('warning', function()
    lib.notify({
        title       = 'Heads Up',
        description = 'Proceed with caution — this action may be irreversible.',
        type        = 'warning',
        duration    = 4500,
    })
end, false)

-- /info
RegisterCommand('info', function()
    lib.notify({
        title       = 'Did You Know?',
        description = 'jd_lib is now active on this server.',
        type        = 'info',
        duration    = 4000,
    })
end, false)

-- Generic: /notify success "Title" "Description"
RegisterCommand('notify', function(source, args)
    local nType = args[1] or 'info'
    local title = args[2] or 'Notification'
    local desc  = args[3] or ''

    lib.notify({
        title       = title,
        description = desc,
        type        = nType,
        duration    = 4000,
    })
end, false)
