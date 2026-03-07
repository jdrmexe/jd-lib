// ── JD Library · Noti-Menu Module ───────────────────────────────

const NOTI_TYPES = [
    {
        type:    'success',
        label:   'Success',
        desc:    'Positive confirmation notification',
        icon:    `<svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>`,
        title:   'Success',
        message: 'This is a success notification.',
    },
    {
        type:    'error',
        label:   'Error',
        desc:    'Something went wrong notification',
        icon:    `<svg viewBox="0 0 24 24"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>`,
        title:   'Error',
        message: 'This is an error notification.',
    },
    {
        type:    'warning',
        label:   'Warning',
        desc:    'Caution or heads-up notification',
        icon:    `<svg viewBox="0 0 24 24"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>`,
        title:   'Warning',
        message: 'This is a warning notification.',
    },
    {
        type:    'info',
        label:   'Info',
        desc:    'General information notification',
        icon:    `<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>`,
        title:   'Info',
        message: 'This is an info notification.',
    },
    {
        type:    'medical',
        label:   'Medical',
        desc:    'Medical alert notification',
        icon:    `<svg viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="3" ry="3"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>`,
        title:   'Medical',
        message: 'This is a medical notification.',
    },
]

// ── Build panel DOM ───────────────────────────────────────────
function buildPanel() {
    const panel = document.getElementById('jd-noti-menu')
    if (panel.querySelector('.nm-card')) return  // already built

    const card = document.createElement('div')
    card.className = 'nm-card'

    // Header
    card.innerHTML = `
        <div class="nm-header">
            <div class="nm-header-left">
                <div class="nm-logo">
                    <svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg>
                </div>
                <div>
                    <div class="nm-title">Notification Tester</div>
                    <div class="nm-subtitle">jd_lib · /testnotify</div>
                </div>
            </div>
            <div class="nm-close" id="nm-close-btn">
                <svg viewBox="0 0 24 24"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </div>
        </div>
    `

    // Body
    const body = document.createElement('div')
    body.className = 'nm-body'

    NOTI_TYPES.forEach(n => {
        const btn = document.createElement('div')
        btn.className = `nm-btn ${n.type}`
        btn.innerHTML = `
            <div class="nm-icon">${n.icon}</div>
            <div class="nm-btn-text">
                <div class="nm-btn-label">${n.label}</div>
                <div class="nm-btn-desc">${n.desc}</div>
            </div>
            <span class="nm-badge">${n.type}</span>
        `

        btn.addEventListener('click', () => {
            // Fire the notification via the shared notify function
            notify({
                title:       n.title,
                description: n.message,
                type:        n.type,
                duration:    4000,
                position:    'top-right',
            })
        })

        body.appendChild(btn)
    })

    // Footer
    const footer = document.createElement('div')
    footer.className = 'nm-footer'
    footer.innerHTML = `
        <span class="nm-footer-key">Esc</span>
        <span class="nm-footer-sep">or</span>
        <span class="nm-footer-key">/testnotify</span>
        <span class="nm-footer-sep">to close</span>
    `

    card.appendChild(body)
    card.appendChild(footer)
    panel.appendChild(card)

    // Close button
    document.getElementById('nm-close-btn').addEventListener('click', closeNotiMenu)
}

// ── Open ──────────────────────────────────────────────────────
function openNotiMenu() {
    buildPanel()
    document.getElementById('jd-noti-menu').classList.add('open')
}

// ── Close ─────────────────────────────────────────────────────
function closeNotiMenu() {
    document.getElementById('jd-noti-menu').classList.remove('open')

    fetch(`https://${GetParentResourceName()}/notiMenuClose`, {
        method:  'POST',
        headers: { 'Content-Type': 'application/json' },
        body:    JSON.stringify({}),
    }).catch(() => {})
}

// ── Escape key ────────────────────────────────────────────────
document.addEventListener('keydown', e => {
    if (e.key === 'Escape') closeNotiMenu()
})

// ── NUI message listener ──────────────────────────────────────
window.addEventListener('message', ({ data }) => {
    if (!data?.action) return
    if (data.action === 'openNotiMenu')  openNotiMenu()
    if (data.action === 'closeNotiMenu') closeNotiMenu()
})

// ── FiveM parent name helper ──────────────────────────────────
function GetParentResourceName() {
    return typeof window.GetParentResourceName === 'function'
        ? window.GetParentResourceName()
        : 'jd_lib'
}