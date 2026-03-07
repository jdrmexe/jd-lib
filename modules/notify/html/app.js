// ── JD Library · Notify NUI ─────────────────────────────────

const ICONS = {
    success: `<svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>`,
    error:   `<svg viewBox="0 0 24 24"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>`,
    warning: `<svg viewBox="0 0 24 24"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>`,
    info:    `<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>`,
    medical: `<svg viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="3" ry="3"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>`,
}

const VALID_TYPES     = ['success', 'error', 'warning', 'info', 'medical']
const VALID_POSITIONS = ['top-right', 'top-left', 'bottom-right', 'bottom-left']

const root   = document.getElementById('jd-notify-root')
const stacks = {}

// ── Stack manager ─────────────────────────────────────────────
function getStack(position) {
    if (stacks[position]) return stacks[position]
    const el     = document.createElement('div')
    el.className = `jd-stack ${position}`
    root.appendChild(el)
    stacks[position] = el
    return el
}

// ── Sanitize to prevent XSS ───────────────────────────────────
function safe(str) {
    const d       = document.createElement('div')
    d.textContent = String(str ?? '')
    return d.innerHTML
}

// ── Create notification ───────────────────────────────────────
function notify({ title, description, type, duration, position }) {
    type     = VALID_TYPES.includes(type)         ? type     : 'info'
    position = VALID_POSITIONS.includes(position) ? position : 'top-right'
    duration = Math.max(1500, parseInt(duration)  || 4000)

    const durSec = (duration / 1000).toFixed(2) + 's'
    const stack  = getStack(position)
    const toast  = document.createElement('div')

    toast.className = `jd-toast ${type}`
    toast.innerHTML = `
        <div class="jd-body">
            <div class="jd-icon-wrap">${ICONS[type]}</div>
            <div class="jd-text">
                ${title       ? `<div class="jd-title">${safe(title)}</div>`      : ''}
                ${description ? `<div class="jd-desc">${safe(description)}</div>` : ''}
            </div>
        </div>
        <div class="jd-bar" style="--dur:${durSec}"></div>
    `

    // append = newest at bottom, building downward as a list
    stack.appendChild(toast)

    setTimeout(() => dismiss(toast), duration)
}

// ── Dismiss with exit animation ───────────────────────────────
function dismiss(toast) {
    if (toast.classList.contains('leaving')) return
    toast.classList.add('leaving')
    toast.addEventListener('animationend', () => toast.remove(), { once: true })
}

// ── NUI message listener ──────────────────────────────────────
window.addEventListener('message', function (event) {
    const data = event.data
    if (!data || data.action !== 'notify') return
    notify({
        title:       data.title,
        description: data.description,
        type:        data.type,
        duration:    data.duration,
        position:    data.position,
    })
})

// ── Signal Lua that the NUI is ready ─────────────────────────
fetch(`https://${GetParentResourceName()}/ready`, {
    method:  'POST',
    headers: { 'Content-Type': 'application/json' },
    body:    JSON.stringify({}),
}).catch(() => {})