<%@ Page Language="VB" AutoEventWireup="true" CodeFile="SalesOrderTrackerAndExecutionControls.aspx.vb" Inherits="SalesOrderTrackerAndExecutionControls" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>COREPULSE — Execution Controls</title>
<!-- Apply saved theme before any paint to prevent flash -->
<script>(function(){if(localStorage.getItem('cpTheme')==='light')document.documentElement.classList.add('light');})()</script>
<link rel="stylesheet" href="common.css">
<style>
/* ── PAGE-SPECIFIC STYLES (common styles in common.css) ── */
.page{display:none;padding:24px;animation:fadeUp .22s ease}
.page.active{display:block}
/* fadeUp animation defined in common.css */

/* ── PAGE HEADER ── */
.pg-head{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:22px;gap:14px;flex-wrap:wrap}
.pg-head h2{font-family:'Syne',sans-serif;font-size:24px;font-weight:800;color:var(--text);letter-spacing:-.2px}
.pg-head p{color:var(--muted2);font-size:13px;margin-top:2px}
.pg-acts{display:flex;align-items:center;gap:8px;flex-wrap:wrap}

/* ── STAT ROW ── */
.stat-row{display:grid;grid-template-columns:repeat(auto-fill,minmax(170px,1fr));gap:12px;margin-bottom:20px}
.stat-card{background:var(--panel);border:1px solid var(--border);border-radius:var(--rl);padding:16px;position:relative;overflow:hidden;transition:border-color .2s,transform .2s}
.stat-card:hover{border-color:var(--border2);transform:translateY(-1px)}
.stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px}
.sc-a::before{background:linear-gradient(90deg,var(--accent),var(--accent2))}
.sc-b::before{background:linear-gradient(90deg,var(--info),#818cf8)}
.sc-c::before{background:linear-gradient(90deg,var(--warning),#fbbf24)}
.sc-d::before{background:linear-gradient(90deg,var(--success),#34d399)}
.stat-lbl{font-family:'DM Mono',monospace;font-size:10px;color:var(--muted);letter-spacing:.1em;text-transform:uppercase;margin-bottom:8px}
.stat-val{font-family:'Syne',sans-serif;font-size:28px;font-weight:800;color:var(--text);letter-spacing:-1px;line-height:1}
.stat-sub{font-size:11px;color:var(--muted2);margin-top:5px}
.stat-ico{position:absolute;right:14px;top:14px;font-size:20px;opacity:.2}

/* ── SECTION CARD ── */
.card{background:var(--panel);border:1px solid var(--border);border-radius:var(--rl);overflow:hidden}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:16px 18px;border-bottom:1px solid var(--border)}
.card-title{font-family:'Syne',sans-serif;font-size:13px;font-weight:700;color:var(--muted2);letter-spacing:.06em;text-transform:uppercase}
.card-body{padding:18px}

/* ── TOOLBAR ── */
.toolbar{display:flex;align-items:center;gap:8px;margin-bottom:14px;flex-wrap:wrap}
.search-wrap{position:relative;flex:1;min-width:180px;max-width:320px}
.search-wrap input{width:100%;padding:8px 12px 8px 34px;background:var(--panel);border:1px solid var(--border2);border-radius:var(--r);color:var(--text);font-family:'DM Sans',sans-serif;font-size:13px;outline:none;transition:border-color .2s}
.search-wrap input:focus{border-color:var(--accent)}
.search-wrap input::placeholder{color:var(--muted)}
.search-ico{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:13px;pointer-events:none}
select.sel{padding:8px 12px;background:var(--panel);border:1px solid var(--border2);border-radius:var(--r);color:var(--text);font-family:'DM Sans',sans-serif;font-size:13px;outline:none;cursor:pointer;transition:border-color .2s}
select.sel:focus{border-color:var(--accent)}
select.sel option{background:var(--panel2)}

/* ── ALERT BANNERS ── */
.alert{display:flex;align-items:center;gap:10px;padding:11px 16px;border-radius:var(--r);margin-bottom:10px;font-size:13px;border:1px solid;animation:fadeUp .3s ease}
.alert-danger{background:var(--danger-bg);border-color:rgba(255,77,109,.3);color:var(--danger)}
.alert-warning{background:var(--warn-bg);border-color:rgba(245,158,11,.3);color:var(--warning)}

/* ── SHIPMENT CARDS ── */
.shipment-card{background:var(--panel);border:1px solid var(--border);border-radius:var(--rl);padding:20px;margin-bottom:14px;transition:border-color .2s}
.shipment-card:hover{border-color:var(--border2)}
.ship-head{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-bottom:12px;flex-wrap:wrap}
.ship-id{font-family:'Syne',sans-serif;font-size:16px;font-weight:800;color:var(--accent)}
.ship-acts{display:flex;gap:7px}
.ship-meta{display:flex;align-items:center;gap:8px;flex-wrap:wrap;margin-bottom:14px}
.type-pill{display:inline-flex;align-items:center;padding:3px 11px;border-radius:99px;background:var(--accent-g);border:1px solid rgba(0,212,216,.35);color:var(--accent);font-size:11px;font-weight:700;letter-spacing:.04em}
.count-pill{display:inline-flex;align-items:center;padding:3px 10px;border-radius:99px;background:var(--panel2);border:1px solid var(--border2);color:var(--muted2);font-size:11px;font-weight:600;cursor:pointer;transition:all .15s}
.count-pill:hover{background:var(--accent-g);border-color:rgba(0,212,216,.35);color:var(--accent)}

/* Overview grid */
.overview-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(140px,1fr));gap:10px;margin-bottom:14px}
.ov-item{background:var(--bg3);border:1px solid var(--border);border-radius:var(--r);padding:11px 13px}
.ov-lbl{font-family:'DM Mono',monospace;font-size:9px;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:4px}
.ov-val{font-size:13px;color:var(--accent);font-weight:700}

/* Progress */
.prog-wrap{margin-bottom:14px}
.prog-labels{display:flex;justify-content:space-between;font-size:11px;color:var(--muted2);margin-bottom:5px}
.prog-track{width:100%;height:6px;border-radius:99px;background:var(--border2);overflow:hidden}
.prog-fill{height:100%;border-radius:inherit;background:linear-gradient(90deg,var(--accent),var(--accent2));transition:width .4s ease}

/* Milestones */
.milestones-row{display:flex;gap:8px;overflow-x:auto;padding-bottom:4px;scrollbar-width:thin}
.milestone-chip{
  display:inline-flex;flex-direction:column;align-items:flex-start;
  padding:10px 12px;border-radius:var(--r);border:1px solid var(--border);
  background:var(--bg3);min-width:170px;flex:0 0 auto;cursor:pointer;
  transition:border-color .15s,background .15s;
}
.milestone-chip:hover{border-color:var(--border3);background:var(--panel2)}
.mc-header{display:flex;align-items:center;gap:7px;margin-bottom:6px}
.mc-dot{width:7px;height:7px;border-radius:50%;background:var(--accent);flex-shrink:0}
.mc-name{font-size:12px;font-weight:700;color:var(--accent)}
.mc-date{font-size:11px;color:var(--muted2);font-family:'DM Mono',monospace;margin-bottom:6px}
.mc-summary{display:flex;flex-wrap:wrap;gap:4px;border-top:1px solid var(--border);padding-top:7px}
.mc-count{display:inline-flex;align-items:center;padding:2px 7px;border-radius:99px;background:var(--accent-g);border:1px solid rgba(0,212,216,.3);color:var(--accent);font-size:10px;font-weight:600}
.mc-detail-list{display:none;margin-top:7px;border-top:1px dashed var(--border2);padding-top:7px;width:100%}
.mc-entry{padding:5px 0;border-bottom:1px solid var(--border)}
.mc-entry:last-child{border-bottom:none}
.mc-entry-title{font-size:11px;font-weight:700;color:var(--text2);margin-bottom:2px}
.mc-entry-detail{font-size:10px;color:var(--muted2);line-height:1.4;white-space:pre-line}

/* Stage progress pips */
.stage-pips{display:flex;gap:3px;margin-bottom:4px}
.stage-pip{height:4px;flex:1;border-radius:2px;background:var(--border2)}
.stage-pip.done{background:var(--accent)}
.stage-pip.active{background:var(--warning)}
.stage-pip.late{background:var(--danger)}

/* ── CHECKPOINT LIBRARY CARDS ── */
.cp-card{background:var(--panel);border:1px solid var(--border);border-radius:var(--rl);padding:16px;margin-bottom:10px;cursor:pointer;transition:border-color .15s}
.cp-card:hover{border-color:var(--border3)}
.cp-head{display:flex;align-items:flex-start;justify-content:space-between;gap:10px;margin-bottom:10px;flex-wrap:wrap}
.cp-title{font-size:14px;font-weight:700;color:var(--accent);font-family:'Syne',sans-serif}
.cp-acts{display:flex;gap:6px;flex-shrink:0}
.cp-meta{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:8px}
.cp-pill{display:inline-flex;padding:2px 9px;border-radius:99px;background:var(--panel2);border:1px solid var(--border2);color:var(--muted2);font-size:10px;font-weight:600}
.cp-detail{font-size:12.5px;color:var(--muted2);line-height:1.6;white-space:pre-line;margin-bottom:10px;padding:10px 12px;background:var(--bg3);border-radius:var(--r)}
.cp-stages{display:flex;flex-wrap:wrap;gap:5px}
.stage-tag{display:inline-flex;padding:2px 9px;border-radius:99px;background:var(--accent-g);border:1px solid rgba(0,212,216,.25);color:var(--accent);font-size:10px;font-weight:600}
.cp-vl{font-family:'DM Mono',monospace;font-size:9px;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:5px}
.empty-state{text-align:center;padding:48px 20px;color:var(--muted)}
.empty-ico{font-size:36px;margin-bottom:12px}
.empty-state p{font-size:13.5px}

/* ── MODALS ── */
.modal-overlay{position:fixed;inset:0;z-index:300;background:rgba(8,11,15,.87);backdrop-filter:blur(8px);display:none;align-items:center;justify-content:center;padding:20px}
.modal-overlay.open{display:flex;animation:fadeUp .2s ease}
.modal{background:var(--panel);border:1px solid var(--border2);border-radius:var(--rl);width:min(720px,95vw);max-height:88vh;overflow-y:auto;box-shadow:0 40px 80px rgba(0,0,0,.65)}
.modal-lg{width:min(1000px,96vw);max-height:92vh}
.modal-sm{width:min(460px,95vw)}
.modal-head{padding:20px 22px 16px;border-bottom:1px solid var(--border);display:flex;align-items:flex-start;justify-content:space-between;gap:12px;position:sticky;top:0;background:var(--panel);z-index:2}
.modal-head h3{font-family:'Syne',sans-serif;font-size:17px;font-weight:800;color:var(--text)}
.modal-head p{font-size:12px;color:var(--muted2);margin-top:3px}
.modal-close{width:28px;height:28px;border-radius:7px;background:var(--panel2);border:1px solid var(--border);color:var(--muted2);cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:14px;flex-shrink:0;transition:all .15s}
.modal-close:hover{background:var(--danger-bg);color:var(--danger)}
.modal-body{padding:22px}
.modal-footer{padding:14px 22px;border-top:1px solid var(--border);display:flex;justify-content:flex-end;gap:8px;position:sticky;bottom:0;background:var(--panel);z-index:2}

/* ── FORMS ── */
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.fg{display:flex;flex-direction:column;gap:5px}
.fg.span2{grid-column:span 2}
.fg label{font-family:'DM Mono',monospace;font-size:10px;font-weight:500;color:var(--muted);letter-spacing:.1em;text-transform:uppercase}
.fg input,.fg select,.fg textarea{padding:9px 12px;background:var(--bg2);border:1px solid var(--border2);border-radius:var(--r);color:var(--text);font-family:'DM Sans',sans-serif;font-size:13.5px;outline:none;transition:border-color .2s,box-shadow .2s;width:100%}
.fg input:focus,.fg select:focus,.fg textarea:focus{border-color:var(--accent);box-shadow:0 0 0 3px var(--accent-g)}
.fg input::placeholder,.fg textarea::placeholder{color:var(--muted)}
.fg select option{background:var(--panel2)}
.fg textarea{resize:vertical;min-height:90px}
.req{color:var(--danger);margin-left:2px}
/* input[type="date"] color-scheme defined in common.css */

/* ── GANTT CHART (Add Shipment modal) ── */
.gantt-outer{margin-top:16px;border:1px solid var(--border);border-radius:var(--rl);background:var(--bg2);position:relative}
.gantt-scroll{overflow-x:auto;overflow-y:visible;scrollbar-width:thin}
.gantt-inner{min-width:100%}

/* Sticky ruler header — lives OUTSIDE .gantt-scroll */
.gantt-hdr{display:flex;background:var(--bg3);border-bottom:2px solid var(--border2);position:sticky;top:0;z-index:20;border-radius:calc(var(--rl) - 1px) calc(var(--rl) - 1px) 0 0}
.gantt-hdr-label{width:220px;flex-shrink:0;padding:8px 14px;font-family:'DM Mono',monospace;font-size:10px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;border-right:1px solid var(--border2);background:var(--bg3);display:flex;align-items:center}
.gantt-ruler-clip{flex:1;overflow:hidden;height:36px;position:relative}
.gantt-ruler{position:absolute;top:0;left:0;height:36px;will-change:transform}
.gantt-month{position:absolute;top:0;bottom:0;border-left:1px solid var(--border2);display:flex;align-items:center;padding:0 6px}
.gantt-month-lbl{font-family:'DM Mono',monospace;font-size:10px;font-weight:600;color:var(--accent);letter-spacing:.04em;white-space:nowrap}
.gantt-ruler-today{position:absolute;top:0;bottom:0;width:2px;background:var(--danger);opacity:.6;pointer-events:none}

/* Stage rows */
.gantt-row{display:flex;align-items:stretch;border-bottom:1px solid var(--border);background:var(--panel);transition:opacity .2s}
.gantt-row:last-child{border-bottom:none}
.gantt-row.g-off{opacity:.38;pointer-events:none}
.gantt-row-label{width:220px;flex-shrink:0;padding:10px 14px;border-right:1px solid var(--border);display:flex;flex-direction:column;justify-content:center;gap:4px;position:sticky;left:0;z-index:4;background:var(--panel)}
.gantt-row.g-off .gantt-row-label{background:var(--bg2)}
.gantt-row-name{font-size:12px;font-weight:600;color:var(--text2);line-height:1.35}
.gantt-mand-pill{display:inline-flex;padding:1px 7px;border-radius:99px;width:fit-content;background:var(--accent-g);border:1px solid rgba(0,212,216,.3);color:var(--accent);font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.06em}
.gantt-opt-pill{display:inline-flex;padding:1px 7px;border-radius:99px;width:fit-content;background:var(--info-bg);border:1px solid rgba(99,102,241,.25);color:var(--info);font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.06em}

/* Inline range date picker (single row per stage) */
.grd-range{display:flex;align-items:center;gap:3px;margin-top:6px;padding-top:6px;border-top:1px solid var(--border)}
.grd-inp{width:68px;padding:3px 5px;background:var(--bg2);border:1px solid var(--border2);border-radius:5px;color:var(--text);font-family:'DM Mono',monospace;font-size:10px;outline:none;transition:border-color .2s;min-width:0}
.grd-inp:focus{border-color:var(--accent)}
.grd-inp::placeholder{color:var(--muted)}
.grd-sep{color:var(--muted);font-size:11px;flex-shrink:0}
.grd-pick{width:22px;height:22px;border-radius:5px;background:transparent;border:1px solid var(--border2);color:var(--accent);cursor:pointer;display:inline-flex;align-items:center;justify-content:center;font-size:11px;flex-shrink:0;transition:all .15s;padding:0;line-height:1;margin-left:1px}
.grd-pick:hover{background:var(--accent-g);border-color:rgba(0,212,216,.4)}

/* Track */
.gantt-track{flex:1;position:relative;min-height:80px;overflow:visible}
.gantt-grid-vline{position:absolute;top:0;bottom:0;width:1px;background:var(--border);pointer-events:none}
.gantt-track-today{position:absolute;top:0;bottom:0;width:2px;background:var(--danger);opacity:.4;pointer-events:none;z-index:1}

/* Draggable bar */
.gantt-bar{position:absolute;top:50%;transform:translateY(-50%);height:34px;border-radius:8px;min-width:18px;display:flex;align-items:center;cursor:grab;user-select:none;z-index:3;box-shadow:0 2px 10px rgba(0,212,216,.18);transition:box-shadow .15s}
.gantt-bar.gbar-mand{background:linear-gradient(135deg,var(--accent),var(--accent2))}
.gantt-bar.gbar-opt{background:linear-gradient(135deg,var(--info),#818cf8)}
.gantt-bar:hover,.gantt-bar.gbar-drag{box-shadow:0 6px 22px rgba(0,212,216,.38);cursor:grabbing}
.gantt-bar.gbar-opt:hover,.gantt-bar.gbar-opt.gbar-drag{box-shadow:0 6px 22px rgba(99,102,241,.38)}
.gantt-bar-lbl{flex:1;text-align:center;font-family:'DM Mono',monospace;font-size:10px;font-weight:700;color:#000;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;padding:0 3px;pointer-events:none;letter-spacing:.02em}
.gantt-handle{width:11px;height:100%;flex-shrink:0;cursor:ew-resize;display:flex;align-items:center;justify-content:center;opacity:.65}
.gantt-handle::after{content:'';display:block;width:2px;height:13px;border-radius:2px;background:rgba(0,0,0,.5);box-shadow:3px 0 rgba(0,0,0,.3)}
.gantt-handle.gh-right::after{box-shadow:-3px 0 rgba(0,0,0,.3)}

/* ── DATE RANGE PICKER POPUP ── */
.dp-panel{position:fixed;z-index:9999;background:var(--panel);border:1px solid var(--border2);border-radius:var(--rl);box-shadow:0 24px 64px rgba(0,0,0,.6);padding:18px 20px 14px;display:none;user-select:none;min-width:548px}
.dp-months{display:flex;gap:20px}
.dp-month-col{flex:1;min-width:0}
.dp-nav{display:flex;align-items:center;justify-content:space-between;margin-bottom:10px}
.dp-month-title{font-family:'Syne',sans-serif;font-size:13px;font-weight:700;color:var(--text);text-align:center;flex:1}
.dp-nav-btn{width:26px;height:26px;border-radius:7px;background:transparent;border:1px solid var(--border2);color:var(--text2);cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all .15s;flex-shrink:0;padding:0}
.dp-nav-btn:hover{background:var(--accent-g);border-color:rgba(0,212,216,.4);color:var(--accent)}
.dp-nav-spc{width:26px;flex-shrink:0}
.dp-grid{display:grid;grid-template-columns:repeat(7,1fr)}
.dp-dow{font-family:'DM Mono',monospace;font-size:9px;font-weight:600;color:var(--muted);text-align:center;padding:5px 0;text-transform:uppercase;letter-spacing:.06em}
.dp-day{height:32px;display:flex;align-items:center;justify-content:center;font-size:12px;color:var(--text2);cursor:pointer;border-radius:0;position:relative;transition:color .1s}
.dp-day.dp-empty{pointer-events:none}
.dp-day:not(.dp-empty):not(.dp-in-range):hover{background:var(--bg3);border-radius:6px;color:var(--accent)}
.dp-day.dp-today:not(.dp-sel-s):not(.dp-sel-e){color:var(--accent);font-weight:700}
.dp-day.dp-today:not(.dp-sel-s):not(.dp-sel-e)::after{content:'';position:absolute;bottom:2px;left:50%;transform:translateX(-50%);width:3px;height:3px;border-radius:50%;background:var(--accent)}
.dp-day.dp-in-range{background:rgba(0,212,216,.13);color:var(--text)}
.dp-day.dp-in-range:hover{background:rgba(0,212,216,.22)}
.dp-day.dp-sel-s,.dp-day.dp-sel-e{background:var(--accent)!important;color:#000!important;font-weight:700;z-index:1}
.dp-panel:not(.dp-ranged) .dp-sel-s,.dp-panel:not(.dp-ranged) .dp-sel-e{border-radius:6px}
.dp-panel.dp-ranged .dp-sel-s{border-radius:6px 0 0 6px}
.dp-panel.dp-ranged .dp-sel-e{border-radius:0 6px 6px 0}
.dp-panel.dp-ranged .dp-sel-s.dp-rng-alone,.dp-panel.dp-ranged .dp-sel-e.dp-rng-alone{border-radius:6px}
.dp-footer{display:flex;justify-content:flex-end;gap:8px;margin-top:14px;padding-top:12px;border-top:1px solid var(--border)}
.dp-reset{padding:7px 16px;border-radius:var(--r);background:transparent;border:1px solid var(--border2);color:var(--text2);font-size:12px;font-weight:600;cursor:pointer;font-family:'DM Sans',sans-serif;transition:all .15s}
.dp-reset:hover{border-color:var(--border3);background:var(--bg3)}
.dp-apply{padding:7px 20px;border-radius:var(--r);background:var(--accent);border:none;color:#000;font-size:12px;font-weight:700;cursor:pointer;font-family:'DM Sans',sans-serif;transition:opacity .15s}
.dp-apply:hover{opacity:.82}

/* Optional stage toggle modal */
.stg-toggle-list{display:flex;flex-direction:column;gap:6px;margin-top:14px}
.stg-chip{display:inline-flex;align-items:center;justify-content:space-between;gap:10px;width:100%;border:1px solid var(--border2);border-radius:99px;background:var(--panel);color:var(--muted2);padding:8px 14px;font-family:'DM Sans',sans-serif;font-size:12.5px;font-weight:600;cursor:pointer;transition:all .15s}
.stg-chip.is-active{background:var(--accent);border-color:var(--accent);color:#000}
.stg-chip-status{width:18px;height:18px;border-radius:50%;background:rgba(255,255,255,.18);display:flex;align-items:center;justify-content:center;font-size:11px}
.stg-trigger{display:inline-flex;align-items:center;gap:7px;margin-bottom:12px;border:1px solid var(--border2);border-radius:99px;background:var(--panel2);color:var(--text2);padding:8px 14px;font-size:12px;font-weight:600;cursor:pointer;font-family:'DM Sans',sans-serif;transition:all .15s}
.stg-trigger:hover{border-color:var(--accent);color:var(--accent)}

/* Execution control form stages */
.stage-choice-list{display:flex;flex-wrap:wrap;gap:8px;margin-top:8px}
.stage-choice{display:inline-flex;align-items:flex-start;gap:8px;padding:8px 12px;border-radius:var(--r);border:1px solid var(--border2);background:var(--panel2);cursor:pointer;min-width:200px;flex:1 1 200px;transition:border-color .15s}
.stage-choice:hover{border-color:var(--border3)}
.stage-choice input{margin-top:2px;accent-color:var(--accent)}
.sc-name{font-size:12px;font-weight:700;color:var(--text2)}
.sc-sub{font-size:11px;color:var(--muted);margin-top:1px}

/* ── CHECKPOINT LIST MODAL ── */
.cp-list-item{padding:14px 0;border-bottom:1px solid var(--border)}
.cp-list-item:last-child{border-bottom:none}
.cp-list-title{font-size:13px;font-weight:700;color:var(--accent);margin-bottom:5px}
.cp-list-detail{font-size:12px;color:var(--muted2);line-height:1.6;white-space:pre-line;margin-bottom:8px}
.cp-list-stages{display:flex;flex-wrap:wrap;gap:5px}

/* ── TOAST ── */
.toast-area{position:fixed;bottom:20px;right:20px;z-index:500;display:flex;flex-direction:column;gap:7px}
.toast{display:flex;align-items:center;gap:9px;padding:11px 16px;border-radius:var(--r);font-size:13px;font-weight:500;background:var(--panel2);border:1px solid var(--border2);box-shadow:0 20px 40px rgba(0,0,0,.5);animation:fadeUp .3s ease;min-width:260px}
.toast.success{border-color:rgba(16,217,138,.4)}
.toast.danger{border-color:rgba(255,77,109,.4)}

/* ── SECTION LABELS ── */
.sec-label{font-family:'DM Mono',monospace;font-size:10px;font-weight:500;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;margin-bottom:8px;display:block}
.divider{height:1px;background:var(--border);margin:18px 0}

@media(max-width:700px){
  /* header/sidebar responsive handled in common.css */
  .form-grid{grid-template-columns:1fr} .fg.span2{grid-column:span 1}
  .gantt-row-label{width:180px} .gantt-hdr-label{width:180px}
}
</style>
</head>
<body>
<form id="mainForm" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" />

<%-- Hidden fields carry JSON from JS to server on async postback --%>
<asp:HiddenField ID="hfShipments"   runat="server" />
<asp:HiddenField ID="hfCheckpoints" runat="server" />

<%-- UpdatePanel wraps the save trigger — async partial postback, no visible reload --%>
<asp:UpdatePanel ID="upSave" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
    <asp:Button ID="btnSave" runat="server" Style="display:none"
                OnClick="btnSave_Click" Text="Save" CausesValidation="false" />
  </ContentTemplate>
  <Triggers>
    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
  </Triggers>
</asp:UpdatePanel>

<!-- HEADER -->
<header>
  <a class="hdr-logo" href="index.html" aria-label="PGP Energies home">
    <img class="logo-img logo-img-dark"  src="PGP Energies - Full logo - Main.png" alt="PGP Energies">
    <img class="logo-img logo-img-light" src="PgpEnergies Light Teme Logo.png"     alt="PGP Energies">
  </a>
  <div class="hdr-right">
    <span class="hdr-page" id="pageTitleLabel">Execution Controls</span>
    <div class="hdr-acts">
      <button type="button" class="btn btn-ghost btn-sm" onclick="exportCSV()">⬇ Export CSV</button>
      <button type="button" class="btn btn-ghost btn-sm" id="openExecModalBtn">+ Checkpoint</button>
      <button type="button" class="btn btn-accent btn-sm" id="openAddShipBtn">+ Add Shipment</button>
      <button type="button" class="theme-toggle" onclick="toggleTheme()" title="Switch to light mode">&#x2600;&#xFE0F;</button>
    </div>
  </div>
</header>

<!-- SIDEBAR -->
<aside class="sidebar" id="sidebar">
  <div class="sb-section">
    <div class="sb-label">Navigation</div>
    <a class="nav-item" href="index.html">
      <span class="nav-icon">▤</span><span class="nav-lbl">Dashboard</span>
    </a>
    <a class="nav-item active" href="SalesOrderTrackerAndExecutionControls.html">
      <span class="nav-icon">◈</span><span class="nav-lbl">Execution Controls</span>
    </a>
  </div>
  <div class="sb-section">
    <div class="sb-label">Filters</div>
    <a class="nav-item" onclick="filterView('all',this)">
      <span class="nav-icon">☰</span><span class="nav-lbl">All Shipments</span>
      <span class="nav-badge" id="navBadgeAll" style="display:none"></span>
    </a>
    <a class="nav-item" onclick="filterView('overdue',this)">
      <span class="nav-icon">⚠</span><span class="nav-lbl">Overdue</span>
      <span class="nav-badge" id="navBadgeOverdue" style="display:none"></span>
    </a>
    <a class="nav-item" onclick="filterView('checkpoints',this)">
      <span class="nav-icon">◉</span><span class="nav-lbl">Checkpoint Library</span>
    </a>
  </div>
  <div class="sb-footer">
    <button type="button" class="sb-toggle" onclick="toggleSidebar()">
      <span id="sbIcon">◁</span><span id="sbLbl" style="font-size:11px">Collapse</span>
    </button>
  </div>
</aside>

<!-- MAIN -->
<main id="main">

  <!-- EXECUTION CONTROLS PAGE -->
  <div class="page active" id="page-exec">
    <div class="pg-head">
      <div>
        <h2>⚙ Execution Controls</h2>
        <p>Track shipment stages and manage checkpoint definitions</p>
      </div>
      <div class="pg-acts">
        <button type="button" class="btn btn-ghost" onclick="exportCSV()">⬇ Export CSV</button>
        <button type="button" class="btn btn-ghost" id="openExecModalBtn2">+ Checkpoint Definition</button>
        <button type="button" class="btn btn-accent" id="openAddShipBtn2">+ Add Shipment</button>
      </div>
    </div>

    <!-- Stats -->
    <div class="stat-row" id="statRow"></div>

    <!-- Alert banners -->
    <div id="alertBanners"></div>

    <!-- Toolbar -->
    <div class="toolbar">
      <div class="search-wrap">
        <span class="search-ico">⌕</span>
        <input type="text" id="searchInput" placeholder="Search shipments…" oninput="renderShipments()">
      </div>
      <select class="sel" id="filterType" onchange="renderShipments()">
        <option value="">All Types</option>
      </select>
    </div>

    <!-- Shipments list -->
    <div id="shipmentsContainer"></div>

    <div class="divider"></div>

    <!-- Checkpoint library inline -->
    <div class="card" id="cpLibSection">
      <div class="card-head">
        <span class="card-title">Checkpoint Definition Library</span>
        <div style="display:flex;align-items:center;gap:8px">
          <span id="cpCountLabel" style="font-size:12px;color:var(--muted2)">0 checkpoints</span>
          <button type="button" class="btn btn-ghost btn-sm" id="openExecModalBtn3">+ Add</button>
        </div>
      </div>
      <div class="card-body" id="cpLibBody"></div>
    </div>
  </div>

</main>

<!-- ═══ ADD SHIPMENT MODAL ═══ -->
<div class="modal-overlay" id="addShipmentModal">
  <div class="modal modal-lg">
    <div class="modal-head">
      <div>
        <h3 id="addShipTitle">Add New Shipment</h3>
        <p id="addShipSubtitle">Fill in shipment details and configure stage dates.</p>
      </div>
      <button type="button" class="modal-close" onclick="closeModal('addShipmentModal')">✕</button>
    </div>
    <div class="modal-body">
      <div class="form-grid" style="margin-bottom:16px">
        <div class="fg">
          <label>Shipment ID<span class="req">*</span></label>
          <input type="text" id="shipmentId" placeholder="e.g. SHP-001">
        </div>
        <div class="fg">
          <label>Shipment Type<span class="req">*</span></label>
          <select id="shipmentType">
            <option value="">Select a type…</option>
            <option>Stock Shipment</option>
            <option>Stock Machining Shipment</option>
            <option>Stock Incoming Shipment</option>
            <option>Supplier Shipment</option>
          </select>
        </div>
      </div>

      <!-- Stage config section — Gantt chart rendered here by JS -->
      <div id="stageConfigSection" style="display:none">
        <button type="button" class="stg-trigger" id="stgToggleTrigger" style="display:none" onclick="openOptionalModal()">Choose Optional Stages</button>
        <div id="stageConfigContainer"></div>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-ghost" onclick="closeModal('addShipmentModal')">Cancel</button>
      <button type="button" class="btn btn-accent" id="saveShipBtn" onclick="saveShipment()">Add Shipment</button>
    </div>
  </div>
</div>

<!-- ═══ OPTIONAL STAGE MODAL ═══ -->
<div class="modal-overlay" id="optionalStageModal" style="z-index:400">
  <div class="modal modal-sm">
    <div class="modal-head">
      <div><h3>Select Optional Stages</h3><p>Choose which optional stages to include.</p></div>
      <button type="button" class="modal-close" onclick="closeModal('optionalStageModal')">✕</button>
    </div>
    <div class="modal-body">
      <div class="stg-toggle-list" id="stgToggleToolbar"></div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-accent" onclick="closeModal('optionalStageModal')">Done</button>
    </div>
  </div>
</div>

<!-- ═══ CHECKPOINT DEFINITION MODAL ═══ -->
<div class="modal-overlay" id="execControlModal">
  <div class="modal">
    <div class="modal-head">
      <div>
        <h3 id="ecModalTitle">Add Checkpoint Definition</h3>
        <p id="ecModalSubtitle">Define once, auto-applies to all matching shipments.</p>
      </div>
      <button type="button" class="modal-close" onclick="closeModal('execControlModal')">✕</button>
    </div>
    <div class="modal-body">
      <div class="form-grid" style="margin-bottom:14px">
        <div class="fg">
          <label>Shipment Type Context</label>
          <select id="ecShipTypeCtx">
            <option value="__all__">All shipment types</option>
          </select>
        </div>
        <div class="fg">
          <label>Control Type<span class="req">*</span></label>
          <select id="ecControlType">
            <option value="">Select control type…</option>
            <option>COMMERCIAL TERMS</option>
            <option>TECHNICAL TERMS</option>
            <option>SHIPPING TERMS</option>
          </select>
        </div>
        <div class="fg">
          <label>Checkpoint Category<span class="req">*</span></label>
          <select id="ecCategory" disabled>
            <option value="">Select checkpoint category…</option>
          </select>
        </div>
        <div class="fg span2">
          <label>Checklist Details<span class="req">*</span></label>
          <textarea id="ecDetails" placeholder="Enter checklist items or verification notes…"></textarea>
        </div>
      </div>
      <div style="background:var(--bg2);border:1px solid var(--border);border-radius:var(--rl);padding:14px">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px">
          <span class="sec-label" style="margin:0">Applicable Stages</span>
          <span id="ecStageHint" style="font-size:11px;color:var(--muted2)"></span>
        </div>
        <div class="stage-choice-list" id="ecStageList"></div>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-ghost" onclick="closeModal('execControlModal')">Cancel</button>
      <button type="button" class="btn btn-accent" id="ecSaveBtn" onclick="saveCheckpoint()">Add Checkpoint</button>
    </div>
  </div>
</div>

<!-- ═══ CHECKPOINT LIST MODAL ═══ -->
<div class="modal-overlay" id="cpListModal">
  <div class="modal">
    <div class="modal-head">
      <div><h3 id="cpListTitle">Linked Checkpoints</h3><p id="cpListSubtitle"></p></div>
      <button type="button" class="modal-close" onclick="closeModal('cpListModal')">✕</button>
    </div>
    <div class="modal-body" id="cpListBody"></div>
  </div>
</div>

<div class="toast-area" id="toastArea"></div>

<script src="common.js"></script>
<script>
// ═══════════════════════════════════════
// DATA
// ═══════════════════════════════════════
const shipmentTimelines = {
  'Stock Shipment': [
    { name: 'Stock Picked', mandatory: true },
    { name: 'Stock Quality Inspection', mandatory: true },
    { name: 'Delivery To Client', mandatory: true }
  ],
  'Stock Machining Shipment': [
    { name: 'Stock Picked', mandatory: true },
    { name: 'Stock Quality Inspection', mandatory: true },
    { name: 'Machining Receipt', mandatory: true },
    { name: 'Delivery To Client', mandatory: true }
  ],
  'Stock Incoming Shipment': [
    { name: 'Production Start', mandatory: false },
    { name: 'Production Inspection', mandatory: false },
    { name: 'Production Completion', mandatory: false },
    { name: 'Material Readiness Document Approval', mandatory: false },
    { name: 'Material Readiness', mandatory: true },
    { name: 'Material Readiness Inspection', mandatory: false },
    { name: 'Supplier Delivery Scope', mandatory: false },
    { name: 'GRN Allocation', mandatory: true },
    { name: 'Stock Picked', mandatory: true },
    { name: 'Stock Quality Inspection', mandatory: true },
    { name: 'Delivery To Client', mandatory: true }
  ],
  'Supplier Shipment': [
    { name: 'PO Placement', mandatory: true },
    { name: 'PO Acknoledgement', mandatory: true },
    { name: 'Pre Production Document Approval', mandatory: false },
    { name: 'Production Start', mandatory: false },
    { name: 'Production Inspection', mandatory: false },
    { name: 'Production Completion', mandatory: false },
    { name: 'Material Readiness Document Approval', mandatory: true },
    { name: 'Material Readiness', mandatory: true },
    { name: 'Material Readiness Inspection', mandatory: false },
    { name: 'Supplier Delivery Scope', mandatory: true },
    { name: 'Delivery To Client', mandatory: true }
  ]
};

const checkpointTypeCategoryMap = {
  'COMMERCIAL TERMS': ['DELIVERY TIME','PAYMENT TERMS : Letter of Credit','PAYMENT TERMS : Cash Against Document','PAYMENT TERMS : TT/Wire Transfer','PAYMENT TERMS : Open Credit','PAYMENT TERMS : Advance Payment','PERFORMANCE BANK GUARANTEE','LIQUIDATED DAMAGES : Late Delivery','LIQUIDATED DAMAGES : Documentation','CONSEQUENTIAL LOSSES/DAMAGES','WARRANTY AND GUARANTEE','CHANGE ORDER TERMS','CANCELLATION CLAUSE','APPLICABLE LAW AND DISPUTE RESOLUTION'],
  'TECHNICAL TERMS': ['TECHNICAL DOCUMENTATION REQUIREMENT','CERTIFICATION','LENGTH OF PIPE','PIPE ENDS','DIMENSIONAL STANDARDS AND TOLERANCE','QUANTITY TOLERANCE','MECHANICAL TESTS AND PROPERTIES','MARKING ON PRODUCTS','COLOUR CODING REQUIRMENT','MANUFACTURER NAME AND ORIGIN','CHEMICAL COMPOSITION','MECHANICAL PROPERTIES','HYDROSTATIC TEST','FINISH OF END PRODUCT','QUALITY STANDARDS','INSPECTION','PERFORMANCE TESTS','CRITICAL PROJECT RELATED TECHNICAL DOCUMENTS'],
  'SHIPPING TERMS': ['EXPEDITING','FREE ISSUED MATERIALS BY BUYER','FREE STORAGE PERIOD','PACKING AND SHIPPING MARKS','COMPLIANCE WITH CODES, STANDARDS, LAWS AND GOVERNMENT REGULATIONS','PRODUCT RELEASE REQUIRMENTS','DISPATCH OF GOODS','SHIPPING RELEASE NOTE REQUIRMENTS']
};

const MONTHS = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

let shipments = [];
let checkpointDefinitions = [];

// ── LOAD PERSISTED DATA FROM SESSION (server-injected) ──
(function() {
  try {
    shipments             = <%=InitialShipments%>;
    checkpointDefinitions = <%=InitialCheckpoints%>;
  } catch(e) { shipments = []; checkpointDefinitions = []; }
})();

let editingShipIdx = null;
let editingCpIdx = null;
let activeShipDraft = null;
let addPlannerState = null;
let suppressScrollSync = false;
let selectedEcShipType = '__all__';
let currentFilter = 'all';

// ═══════════════════════════════════════
// DATE UTILS
// ═══════════════════════════════════════
function parseLocalDate(s) {
  if (!s) return null;
  s = s.trim();
  const iso = s.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (iso) {
    const d = new Date(+iso[1], +iso[2]-1, +iso[3]);
    return (d.getFullYear()==+iso[1] && d.getMonth()==+iso[2]-1 && d.getDate()==+iso[3]) ? d : null;
  }
  const disp = s.match(/^(\d{1,2})-([A-Za-z]{3})-(\d{4})$/);
  if (!disp) return null;
  const mi = MONTHS.findIndex(m => m.toLowerCase()===disp[2].toLowerCase());
  if (mi===-1) return null;
  const d = new Date(+disp[3], mi, +disp[1]);
  return (d.getFullYear()==+disp[3] && d.getMonth()===mi && d.getDate()==+disp[1]) ? d : null;
}
function fmtInput(d) {
  return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
}
function fmtDisp(d) {
  if (!d) return '';
  return `${String(d.getDate()).padStart(2,'0')}-${MONTHS[d.getMonth()]}-${d.getFullYear()}`;
}
function addDays(d, n) { const r=new Date(d); r.setDate(r.getDate()+n); return r; }
function daysBetween(a, b) { return Math.round((b-a)/86400000); }
function daysInMonth(d) { return new Date(d.getFullYear(), d.getMonth()+1, 0).getDate(); }
function startOfMonth(d) { return new Date(d.getFullYear(), d.getMonth(), 1); }
function endOfMonth(d) { return new Date(d.getFullYear(), d.getMonth()+1, 0); }
function fmtSpan(days) {
  if (!days || days<1) return '-';
  const m=Math.floor(days/30), r=days%30, w=Math.floor(r/7), d=r%7;
  const p=(v,l)=>`${v} ${l}${v===1?'':'s'}`;
  if (days<7) return p(days,'Day');
  if (days<30) return [p(w,'Week'), d>0?p(d,'Day'):''].filter(Boolean).join(' ');
  return [p(m,'Month'), w>0?p(w,'Week'):'', d>0?p(d,'Day'):''].filter(Boolean).join(' ');
}
function getTimestamp() {
  return new Date().toLocaleString(undefined,{year:'numeric',month:'short',day:'2-digit',hour:'2-digit',minute:'2-digit'});
}

// ═══════════════════════════════════════
// GANTT STATE
// ═══════════════════════════════════════
let ganttData = {};   // { stageName: { startDate, endDate, applicable } }
let ganttRange = { start: null, end: null };
let DAY_PX = 22;      // pixels per day (recalculated on render)
let ganttHdrEl = null; // reference for sticky-header scroll sync

function dateToX(d) { return daysBetween(ganttRange.start, d) * DAY_PX; }
function xToDate(x) { return addDays(ganttRange.start, Math.round(x / DAY_PX)); }

// ═══════════════════════════════════════
// SIDEBAR & NAVIGATION
// ═══════════════════════════════════════
// toggleSidebar defined in common.js

function filterView(type, el) {
  currentFilter = type;
  document.querySelectorAll('.nav-item').forEach(n=>n.classList.remove('active'));
  if (el) el.classList.add('active');
  if (type==='checkpoints') {
    document.getElementById('cpLibSection').scrollIntoView({behavior:'smooth'});
  } else {
    renderShipments();
  }
}

// openModal / closeModal / backdrop click handler defined in common.js

// ═══════════════════════════════════════
// ADD SHIPMENT MODAL
// ═══════════════════════════════════════
function openAddShipmentModal(idx) {
  editingShipIdx = typeof idx==='number' ? idx : null;
  document.getElementById('addShipTitle').textContent = editingShipIdx!==null ? 'Edit Shipment' : 'Add New Shipment';
  document.getElementById('addShipSubtitle').textContent = editingShipIdx!==null ? 'Update shipment details and stage dates.' : 'Fill in shipment details and configure stage dates.';
  document.getElementById('saveShipBtn').textContent = editingShipIdx!==null ? 'Save Changes' : 'Add Shipment';
  document.getElementById('shipmentId').value = '';
  document.getElementById('shipmentType').value = '';
  document.getElementById('stageConfigSection').style.display='none';
  document.getElementById('stageConfigContainer').innerHTML='';
  document.getElementById('stgToggleToolbar').innerHTML='';
  document.getElementById('stgToggleTrigger').style.display='none';
  addPlannerState=null; activeShipDraft=null; ganttData={};

  if (editingShipIdx!==null) {
    const sh = shipments[editingShipIdx];
    if (!sh) return;
    activeShipDraft = { id:sh.id, type:sh.type, timeline:sh.timeline.map(s=>({name:s.name, startDate:s.startDate||'', date:s.date||''})) };
    document.getElementById('shipmentId').value = sh.id;
    document.getElementById('shipmentType').value = sh.type;
    renderStageConfigRows();
  }
  openModal('addShipmentModal');
}

function saveShipment() {
  const id = document.getElementById('shipmentId').value.trim();
  const type = document.getElementById('shipmentType').value;
  if (!id) { showToast('Please enter a Shipment ID.','danger'); return; }
  if (!type) { showToast('Please select a shipment type.','danger'); return; }
  const timeline = getSelectedTimeline(type);
  if (!timeline.length) { showToast('Please configure at least one stage date.','danger'); return; }
  const dup = shipments.findIndex(s=>s.id===id);
  if (dup!==-1 && dup!==editingShipIdx) { showToast('Shipment ID already exists.','danger'); return; }
  const ship = {id, type, timeline};
  if (editingShipIdx===null) shipments.push(ship);
  else shipments[editingShipIdx] = ship;
  closeModal('addShipmentModal');
  showToast(editingShipIdx===null ? 'Shipment added ✓' : 'Shipment updated ✓', 'success');
  editingShipIdx=null;
  renderAll();
}

function getSelectedTimeline(type) {
  const stages = shipmentTimelines[type]||[];
  const result=[];
  stages.forEach(stage=>{
    const data = ganttData[stage.name];
    if (!data || !data.applicable) return;
    result.push({
      name: stage.name,
      startDate: data.startDate ? fmtInput(data.startDate) : '',
      date: data.endDate ? fmtInput(data.endDate) : '',
    });
  });
  return result;
}

document.getElementById('shipmentType').addEventListener('change', renderStageConfigRows);

// ═══════════════════════════════════════
// GANTT — BUILD & RENDER
// ═══════════════════════════════════════
function renderStageConfigRows() {
  const type = document.getElementById('shipmentType').value;
  const container = document.getElementById('stageConfigContainer');
  const toolbar   = document.getElementById('stgToggleToolbar');
  const trigger   = document.getElementById('stgToggleTrigger');
  container.innerHTML=''; toolbar.innerHTML=''; trigger.style.display='none';
  ganttData={}; addPlannerState=null;

  if (!type) { document.getElementById('stageConfigSection').style.display='none'; return; }
  const stages = shipmentTimelines[type]||[];
  if (!stages.length) { document.getElementById('stageConfigSection').style.display='none'; return; }
  document.getElementById('stageConfigSection').style.display='block';

  // Resolve initial dates from existing draft or defaults
  const today = new Date(); today.setHours(0,0,0,0);
  const existMap = new Map(
    activeShipDraft && activeShipDraft.type===type
      ? activeShipDraft.timeline.map(s=>[s.name,{sd:s.startDate,ed:s.date}])
      : []
  );
  let cursor = new Date(today);
  stages.forEach(stage => {
    const ex = existMap.get(stage.name);
    let sd = ex && ex.sd ? (parseLocalDate(ex.sd)||new Date(cursor)) : new Date(cursor);
    let ed = ex && ex.ed ? (parseLocalDate(ex.ed)||addDays(sd,14))   : addDays(sd,14);
    if (ed <= sd) ed = addDays(sd,1);
    const applicable = stage.mandatory || !activeShipDraft || existMap.has(stage.name);
    ganttData[stage.name] = { startDate:sd, endDate:ed, applicable:!!applicable };
    cursor = new Date(ed);
  });

  // Calc gantt time range (month-aligned + 1 month padding each side)
  const allD = Object.values(ganttData).flatMap(d=>[d.startDate,d.endDate]);
  let gS = new Date(Math.min(...allD)); gS = new Date(gS.getFullYear(),gS.getMonth()-1,1);
  let gE = new Date(Math.max(...allD)); gE = new Date(gE.getFullYear(),gE.getMonth()+2,0);
  ganttRange = { start:gS, end:gE };

  // Adaptive day width: aim for 700px visible
  const totalD = daysBetween(gS,gE)+1;
  DAY_PX = Math.max(16, Math.min(32, Math.floor(700/totalD)));
  const tlW = totalD * DAY_PX;

  // Build DOM
  const outer  = document.createElement('div'); outer.className='gantt-outer';
  const scroll = document.createElement('div'); scroll.className='gantt-scroll';
  const inner  = document.createElement('div'); inner.className='gantt-inner';
  inner.style.width = (220+tlW)+'px';

  // Header lives OUTSIDE scroll so it can be position:sticky in the modal
  ganttHdrEl = _buildRuler(gS,gE,tlW);
  outer.appendChild(ganttHdrEl);
  outer.appendChild(scroll); scroll.appendChild(inner);

  // Sync ruler translate with horizontal scroll
  scroll.addEventListener('scroll', () => {
    const ruler = ganttHdrEl.querySelector('.gantt-ruler');
    if (ruler) ruler.style.transform = `translateX(-${scroll.scrollLeft}px)`;
  });

  stages.forEach(stage => {
    inner.appendChild(_buildGanttRow(stage, gS, tlW));
  });

  container.appendChild(outer);

  // Optional stage chips
  const hasOpt = stages.some(s=>!s.mandatory);
  if (hasOpt) {
    trigger.style.display='inline-flex';
    stages.filter(s=>!s.mandatory).forEach(stage=>{
      const chip = document.createElement('button');
      chip.type='button';
      const act = ganttData[stage.name].applicable;
      chip.className='stg-chip'+(act?' is-active':'');
      chip.dataset.stageName=stage.name;
      chip.setAttribute('aria-pressed', act?'true':'false');
      chip.innerHTML=`<span class="stg-chip-name">${stage.name}</span><span class="stg-chip-status">${act?'✓':'✕'}</span>`;
      chip.addEventListener('click',()=>{
        const on = chip.classList.toggle('is-active');
        chip.setAttribute('aria-pressed',on?'true':'false');
        chip.querySelector('.stg-chip-status').textContent=on?'✓':'✕';
        ganttData[stage.name].applicable=on;
        inner.querySelector(`.gantt-row[data-sn="${_esc(stage.name)}"]`)?.classList.toggle('g-off',!on);
        updateTriggerLabel();
      });
      toolbar.appendChild(chip);
    });
    updateTriggerLabel();
  }
}

function _esc(s){ return s.replace(/["\\]/g,'\\$&'); }

function _buildRuler(gS,gE,tlW){
  const hdr=document.createElement('div'); hdr.className='gantt-hdr';
  hdr.innerHTML='<div class="gantt-hdr-label">Stage</div>';
  const clip=document.createElement('div'); clip.className='gantt-ruler-clip';
  const ruler=document.createElement('div'); ruler.className='gantt-ruler'; ruler.style.width=tlW+'px';
  // Month labels
  let cur=new Date(gS.getFullYear(),gS.getMonth(),1);
  while(cur<=gE){
    const x=dateToX(cur);
    const dm=daysInMonth(cur); const w=dm*DAY_PX;
    const m=document.createElement('div'); m.className='gantt-month';
    m.style.left=x+'px'; m.style.width=w+'px';
    m.innerHTML=`<span class="gantt-month-lbl">${cur.toLocaleDateString(undefined,{month:'short',year:'2-digit'})}</span>`;
    ruler.appendChild(m);
    cur=new Date(cur.getFullYear(),cur.getMonth()+1,1);
  }
  // Today marker in ruler
  const td=new Date(); td.setHours(0,0,0,0);
  if(td>=gS&&td<=gE){
    const tm=document.createElement('div'); tm.className='gantt-ruler-today';
    tm.style.left=dateToX(td)+'px'; ruler.appendChild(tm);
  }
  clip.appendChild(ruler); hdr.appendChild(clip); return hdr;
}

function _buildGanttRow(stage,gS,tlW){
  const data=ganttData[stage.name];
  const row=document.createElement('div');
  row.className='gantt-row'+(data.applicable?'':' g-off');
  row.dataset.sn=stage.name;

  // Label with single-row range date picker
  const lbl=document.createElement('div'); lbl.className='gantt-row-label';
  lbl.innerHTML=`
    <div class="gantt-row-name">${stage.name}</div>
    <div class="${stage.mandatory?'gantt-mand-pill':'gantt-opt-pill'}">${stage.mandatory?'Mandatory':'Optional'}</div>
    <div class="grd-range">
      <input class="grd-inp" type="text" data-sn="${stage.name}" data-role="start"
             value="${fmtDisp(data.startDate)}" placeholder="Start" readonly>
      <span class="grd-sep">—</span>
      <input class="grd-inp" type="text" data-sn="${stage.name}" data-role="end"
             value="${fmtDisp(data.endDate)}" placeholder="End" readonly>
      <button type="button" class="grd-pick" title="Pick date range">&#x1F4C5;</button>
    </div>`;
  lbl.querySelector('.grd-pick').addEventListener('click', e => {
    e.stopPropagation();
    openDatePicker(stage.name, e.currentTarget);
  });
  lbl.querySelector('[data-role="start"]').addEventListener('click', e => {
    e.stopPropagation();
    openDatePicker(stage.name, e.currentTarget);
  });
  lbl.querySelector('[data-role="end"]').addEventListener('click', e => {
    e.stopPropagation();
    openDatePicker(stage.name, e.currentTarget);
  });

  // Track
  const track=document.createElement('div'); track.className='gantt-track';
  track.style.width=tlW+'px';

  // Month grid lines
  let cur=new Date(gS.getFullYear(),gS.getMonth(),1);
  while(cur<=ganttRange.end){
    const gl=document.createElement('div'); gl.className='gantt-grid-vline';
    gl.style.left=dateToX(cur)+'px'; track.appendChild(gl);
    cur=new Date(cur.getFullYear(),cur.getMonth()+1,1);
  }
  // Today line
  const td=new Date(); td.setHours(0,0,0,0);
  if(td>=gS&&td<=ganttRange.end){
    const tl=document.createElement('div'); tl.className='gantt-track-today';
    tl.style.left=dateToX(td)+'px'; track.appendChild(tl);
  }

  // Bar
  const bar=_makeBar(stage,data);
  track.appendChild(bar);

  row.appendChild(lbl); row.appendChild(track);
  return row;
}

function _makeBar(stage,data){
  const x1=dateToX(data.startDate), x2=dateToX(data.endDate);
  const w=Math.max(18,x2-x1);
  const dur=daysBetween(data.startDate,data.endDate);

  const bar=document.createElement('div');
  bar.className='gantt-bar '+(stage.mandatory?'gbar-mand':'gbar-opt');
  bar.dataset.sn=stage.name;
  bar.style.left=x1+'px'; bar.style.width=w+'px';
  bar.title=`${stage.name}\n${fmtDisp(data.startDate)} → ${fmtDisp(data.endDate)} (${dur}d)`;

  bar.innerHTML=`
    <div class="gantt-handle gh-left"  data-role="left"></div>
    <span class="gantt-bar-lbl">${dur>0?dur+'d':''}</span>
    <div class="gantt-handle gh-right" data-role="right"></div>`;

  _wireDrag(bar,stage);
  return bar;
}

function _refreshBar(stageName){
  const data=ganttData[stageName];
  const bar=document.querySelector(`.gantt-bar[data-sn="${_esc(stageName)}"]`);
  if(!bar||!data) return;
  const x1=dateToX(data.startDate), x2=dateToX(data.endDate);
  const w=Math.max(18,x2-x1);
  const dur=daysBetween(data.startDate,data.endDate);
  bar.style.left=x1+'px'; bar.style.width=w+'px';
  bar.title=`${stageName}\n${fmtDisp(data.startDate)} → ${fmtDisp(data.endDate)} (${dur}d)`;
  const lbl=bar.querySelector('.gantt-bar-lbl');
  if(lbl) lbl.textContent=dur>0?dur+'d':'';
}

function _syncRowDates(stageName){
  const data=ganttData[stageName];
  const si=document.querySelector(`.grd-inp[data-sn="${_esc(stageName)}"][data-role="start"]`);
  const ei=document.querySelector(`.grd-inp[data-sn="${_esc(stageName)}"][data-role="end"]`);
  if(si) si.value=fmtDisp(data.startDate);
  if(ei) ei.value=fmtDisp(data.endDate);
}

function _maybeExpandGantt(){
  const allEnds=Object.values(ganttData).map(d=>d.endDate.getTime());
  if(!allEnds.length) return;
  const maxEnd=new Date(Math.max(...allEnds));
  // Expand when any bar is within 14 days of the right edge
  if(maxEnd.getTime() < addDays(ganttRange.end,-14).getTime()) return;
  // Grow by 2 months
  ganttRange.end=new Date(ganttRange.end.getFullYear(),ganttRange.end.getMonth()+2,0);
  const totalD=daysBetween(ganttRange.start,ganttRange.end)+1;
  const tlW=totalD*DAY_PX;
  const LBL=220;
  const inner=document.querySelector('.gantt-inner');
  if(!inner) return;
  inner.style.width=(LBL+tlW)+'px';
  // Rebuild ruler (in sticky header)
  const ruler=ganttHdrEl&&ganttHdrEl.querySelector('.gantt-ruler');
  if(ruler){
    ruler.style.width=tlW+'px';
    ruler.innerHTML='';
    let cur=new Date(ganttRange.start.getFullYear(),ganttRange.start.getMonth(),1);
    while(cur<=ganttRange.end){
      const x=dateToX(cur); const dm=daysInMonth(cur); const w=dm*DAY_PX;
      const m=document.createElement('div'); m.className='gantt-month';
      m.style.left=x+'px'; m.style.width=w+'px';
      m.innerHTML=`<span class="gantt-month-lbl">${cur.toLocaleDateString(undefined,{month:'short',year:'2-digit'})}</span>`;
      ruler.appendChild(m);
      cur=new Date(cur.getFullYear(),cur.getMonth()+1,1);
    }
    const td=new Date(); td.setHours(0,0,0,0);
    if(td>=ganttRange.start&&td<=ganttRange.end){
      const tm=document.createElement('div'); tm.className='gantt-ruler-today';
      tm.style.left=dateToX(td)+'px'; ruler.appendChild(tm);
    }
  }
  // Rebuild grid lines in every track
  inner.querySelectorAll('.gantt-track').forEach(track=>{
    track.style.width=tlW+'px';
    track.querySelectorAll('.gantt-grid-vline').forEach(v=>v.remove());
    let cur=new Date(ganttRange.start.getFullYear(),ganttRange.start.getMonth(),1);
    while(cur<=ganttRange.end){
      const gl=document.createElement('div'); gl.className='gantt-grid-vline';
      gl.style.left=dateToX(cur)+'px'; track.appendChild(gl);
      cur=new Date(cur.getFullYear(),cur.getMonth()+1,1);
    }
    track.querySelectorAll('.gantt-track-today').forEach(v=>v.remove());
    const td=new Date(); td.setHours(0,0,0,0);
    if(td>=ganttRange.start&&td<=ganttRange.end){
      const tl=document.createElement('div'); tl.className='gantt-track-today';
      tl.style.left=dateToX(td)+'px'; track.appendChild(tl);
    }
  });
}

function _wireDrag(bar,stage){
  let mode=null, x0=0, sd0,ed0;

  function startDrag(e,role){
    e.preventDefault(); e.stopPropagation();
    mode=role; x0=e.clientX||e.touches?.[0]?.clientX||0;
    sd0=new Date(ganttData[stage.name].startDate);
    ed0=new Date(ganttData[stage.name].endDate);
    bar.classList.add('gbar-drag');
    document.addEventListener('mousemove',onMove);
    document.addEventListener('mouseup',endDrag);
    document.addEventListener('touchmove',onTouchMove,{passive:false});
    document.addEventListener('touchend',endDrag);
  }

  bar.addEventListener('mousedown',e=>{
    if(e.target.dataset.role) return;
    startDrag(e,'move');
  });
  bar.querySelectorAll('.gantt-handle').forEach(h=>{
    h.addEventListener('mousedown',e=>startDrag(e,h.dataset.role));
  });
  bar.addEventListener('touchstart',e=>{
    if(e.target.dataset.role) return;
    startDrag(e,'move');
  },{passive:false});
  bar.querySelectorAll('.gantt-handle').forEach(h=>{
    h.addEventListener('touchstart',e=>startDrag(e,h.dataset.role),{passive:false});
  });

  function applyDelta(clientX){
    const dx=clientX-x0;
    const dd=Math.round(dx/DAY_PX);
    let ns=new Date(sd0), ne=new Date(ed0);
    if(mode==='move'){ ns=addDays(sd0,dd); ne=addDays(ed0,dd); }
    else if(mode==='left'){ ns=addDays(sd0,dd); if(ns>=ne) ns=addDays(ne,-1); }
    else if(mode==='right'){ ne=addDays(ed0,dd); if(ne<=ns) ne=addDays(ns,1); }
    // Clamp left edge only; right edge auto-expands via _maybeExpandGantt
    if(ns<ganttRange.start){ const d2=daysBetween(ns,ganttRange.start); if(mode==='move') ne=addDays(ne,d2); ns=new Date(ganttRange.start); }
    if(ns>=ne) ne=addDays(ns,1);
    ganttData[stage.name].startDate=ns; ganttData[stage.name].endDate=ne;
    _refreshBar(stage.name); _syncRowDates(stage.name); _maybeExpandGantt();
  }

  function onMove(e){ applyDelta(e.clientX); }
  function onTouchMove(e){ e.preventDefault(); applyDelta(e.touches[0].clientX); }
  function endDrag(){ bar.classList.remove('gbar-drag'); mode=null;
    document.removeEventListener('mousemove',onMove);
    document.removeEventListener('mouseup',endDrag);
    document.removeEventListener('touchmove',onTouchMove);
    document.removeEventListener('touchend',endDrag);
  }
}

// ═══════════════════════════════════════
// CUSTOM DATE RANGE PICKER
// ═══════════════════════════════════════
let _dpStage=null, _dpPhase='start';
let _dpStart=null, _dpEnd=null, _dpOrig={s:null,e:null}, _dpHover=null;
let _dpVY=0, _dpVM=0;

function openDatePicker(stageName) {
  const d=ganttData[stageName]; if(!d) return;
  _dpStage=stageName;
  _dpStart=new Date(d.startDate); _dpEnd=new Date(d.endDate);
  _dpOrig={s:new Date(d.startDate),e:new Date(d.endDate)};
  _dpPhase='start'; _dpHover=null;
  _dpVY=_dpStart.getFullYear(); _dpVM=_dpStart.getMonth();

  let panel=document.getElementById('dpPanel');
  if(!panel){ panel=_buildDpDOM(); document.body.appendChild(panel); }
  _renderDp();

  // Position near the row
  const row=document.querySelector(`.gantt-row[data-sn="${_esc(stageName)}"]`);
  if(row){
    const rect=row.getBoundingClientRect();
    const pw=panel.offsetWidth||548, ph=panel.offsetHeight||380;
    let top=rect.bottom+6, left=rect.left;
    if(left+pw>window.innerWidth-8) left=window.innerWidth-pw-8;
    if(top+ph>window.innerHeight-8) top=rect.top-ph-6;
    panel.style.top=Math.max(8,top)+'px'; panel.style.left=Math.max(8,left)+'px';
  }
  panel.style.display='block';
  setTimeout(()=>document.addEventListener('mousedown',_dpClickOut,true),10);
}

function _buildDpDOM(){
  const p=document.createElement('div'); p.id='dpPanel'; p.className='dp-panel';
  p.innerHTML=`
    <div class="dp-months">
      <div id="dpL" class="dp-month-col"></div>
      <div id="dpR" class="dp-month-col"></div>
    </div>
    <div class="dp-footer">
      <button type="button" class="dp-reset" type="button" id="dpBtnReset">Reset</button>
      <button type="button" class="dp-apply" type="button" id="dpBtnApply">Apply</button>
    </div>`;
  p.querySelector('#dpBtnReset').addEventListener('click',e=>{
    e.stopPropagation();
    _dpStart=new Date(_dpOrig.s); _dpEnd=new Date(_dpOrig.e);
    _dpPhase='start'; _dpHover=null; _renderDp();
  });
  p.querySelector('#dpBtnApply').addEventListener('click',e=>{
    e.stopPropagation();
    if(_dpStage&&_dpStart&&_dpEnd){
      const lo=_dpStart<_dpEnd?_dpStart:_dpEnd;
      const hi=_dpStart<_dpEnd?_dpEnd:_dpStart;
      ganttData[_dpStage].startDate=new Date(lo);
      ganttData[_dpStage].endDate=new Date(hi);
      _refreshBar(_dpStage); _syncRowDates(_dpStage); _maybeExpandGantt();
    }
    _closeDp();
  });
  return p;
}

function _closeDp(){
  const p=document.getElementById('dpPanel');
  if(p) p.style.display='none';
  document.removeEventListener('mousedown',_dpClickOut,true);
  _dpStage=null; _dpHover=null;
}

function _dpClickOut(e){
  const p=document.getElementById('dpPanel');
  if(p&&!p.contains(e.target)) _closeDp();
}

function _renderDp(){
  const rM=_dpVM===11?0:_dpVM+1, rY=_dpVM===11?_dpVY+1:_dpVY;
  _renderDpMonth('dpL',_dpVY,_dpVM,'prev');
  _renderDpMonth('dpR',rY,rM,'next');
  _updRangeCls();
}

function _renderDpMonth(id,year,month,side){
  const el=document.getElementById(id); if(!el) return;
  const title=new Date(year,month,1).toLocaleDateString(undefined,{month:'long',year:'numeric'});
  el.innerHTML=`
    <div class="dp-nav">
      ${side==='prev'?`<button type="button" class="dp-nav-btn" id="dpPrev" type="button">&#8249;</button>`:`<span class="dp-nav-spc"></span>`}
      <div class="dp-month-title">${title}</div>
      ${side==='next'?`<button type="button" class="dp-nav-btn" id="dpNext" type="button">&#8250;</button>`:`<span class="dp-nav-spc"></span>`}
    </div>
    <div class="dp-grid">
      <div class="dp-dow">Mon</div><div class="dp-dow">Tue</div><div class="dp-dow">Wed</div>
      <div class="dp-dow">Thu</div><div class="dp-dow">Fri</div><div class="dp-dow">Sat</div>
      <div class="dp-dow">Sun</div>
    </div>`;

  if(side==='prev'){
    el.querySelector('#dpPrev').addEventListener('click',e=>{
      e.stopPropagation();
      if(_dpVM===0){_dpVM=11;_dpVY--;} else _dpVM--;
      _renderDp();
    });
  } else {
    el.querySelector('#dpNext').addEventListener('click',e=>{
      e.stopPropagation();
      if(_dpVM===11){_dpVM=0;_dpVY++;} else _dpVM++;
      _renderDp();
    });
  }

  const grid=el.querySelector('.dp-grid');
  const today=new Date(); today.setHours(0,0,0,0);
  // Mon-first offset
  let dow=new Date(year,month,1).getDay();
  dow=dow===0?6:dow-1;
  for(let i=0;i<dow;i++){ const c=document.createElement('div'); c.className='dp-day dp-empty'; grid.appendChild(c); }

  const dim=new Date(year,month+1,0).getDate();
  for(let d=1;d<=dim;d++){
    const date=new Date(year,month,d);
    const cell=document.createElement('div');
    cell.className='dp-day'; cell.dataset.ts=date.getTime(); cell.textContent=d;
    if(date.getTime()===today.getTime()) cell.classList.add('dp-today');
    cell.addEventListener('click',e=>{ e.stopPropagation(); _dpDayClick(new Date(year,month,d)); });
    cell.addEventListener('mouseenter',()=>{ if(_dpPhase==='end'){_dpHover=new Date(year,month,d); _updRangeCls();} });
    cell.addEventListener('mouseleave',()=>{ if(_dpPhase==='end'){_dpHover=null; _updRangeCls();} });
    grid.appendChild(cell);
  }
}

function _dpDayClick(date){
  if(_dpPhase==='start'){
    _dpStart=new Date(date); _dpEnd=null; _dpPhase='end'; _dpHover=null;
  } else {
    if(date<_dpStart){
      _dpEnd=new Date(_dpStart); _dpStart=new Date(date);
    } else if(date.getTime()===_dpStart.getTime()){
      _dpEnd=new Date(date); // same day range
    } else {
      _dpEnd=new Date(date);
    }
    _dpPhase='start'; _dpHover=null;
  }
  _updRangeCls();
}

function _updRangeCls(){
  const panel=document.getElementById('dpPanel'); if(!panel) return;
  const effEnd=(_dpPhase==='end'&&_dpHover)?_dpHover:_dpEnd;
  const hasRange=_dpStart&&effEnd&&_dpStart.getTime()!==effEnd.getTime();
  panel.classList.toggle('dp-ranged', !!hasRange);

  const lo=hasRange?(_dpStart<effEnd?_dpStart:effEnd):null;
  const hi=hasRange?(_dpStart<effEnd?effEnd:_dpStart):null;

  panel.querySelectorAll('.dp-day[data-ts]').forEach(cell=>{
    const ts=parseInt(cell.dataset.ts);
    cell.classList.remove('dp-sel-s','dp-sel-e','dp-in-range','dp-rng-alone');
    if(_dpStart&&ts===_dpStart.getTime()) cell.classList.add('dp-sel-s');
    if(_dpPhase==='start'&&effEnd&&ts===effEnd.getTime()&&ts!==(_dpStart&&_dpStart.getTime()))
      cell.classList.add('dp-sel-e');
    if(lo&&hi){ const d=new Date(ts);
      if(d>lo&&d<hi) cell.classList.add('dp-in-range');
    }
  });
}

function updateTriggerLabel() {
  const chips = document.querySelectorAll('#stgToggleToolbar .stg-chip');
  if (!chips.length) { document.getElementById('stgToggleTrigger').style.display='none'; return; }
  const active = [...chips].filter(c=>c.classList.contains('is-active')).length;
  document.getElementById('stgToggleTrigger').style.display='inline-flex';
  document.getElementById('stgToggleTrigger').textContent=`Choose Optional Stages (${active}/${chips.length} selected)`;
}

function openOptionalModal() { openModal('optionalStageModal'); }

// ═══════════════════════════════════════
// CHECKPOINT MODAL
// ═══════════════════════════════════════
function openCheckpointModal(idx) {
  editingCpIdx = typeof idx==='number' ? idx : null;
  const cp = editingCpIdx!==null ? checkpointDefinitions[editingCpIdx] : null;
  document.getElementById('ecModalTitle').textContent = cp ? 'Edit Checkpoint Definition' : 'Add Checkpoint Definition';
  document.getElementById('ecModalSubtitle').textContent = cp ? 'Update checkpoint details and stage mappings.' : 'Define once, auto-applies to all matching shipments.';
  document.getElementById('ecSaveBtn').textContent = cp ? 'Save Changes' : 'Add Checkpoint';

  // Populate ship type context
  document.getElementById('ecShipTypeCtx').innerHTML = ['<option value="__all__">All shipment types</option>',
    ...Object.keys(shipmentTimelines).map(t=>`<option value="${t}">${t}</option>`)].join('');
  document.getElementById('ecShipTypeCtx').value = selectedEcShipType;
  document.getElementById('ecControlType').value = cp?.type||'';
  renderCategoryOptions(cp?.category||'');
  document.getElementById('ecDetails').value = cp?.checklistDetails||'';
  renderStageChoices(cp?.verificationStages||[]);
  openModal('execControlModal');
}

document.getElementById('ecShipTypeCtx').addEventListener('change', function(){
  selectedEcShipType = this.value||'__all__';
  renderStageChoices([]);
});
document.getElementById('ecControlType').addEventListener('change', function(){
  renderCategoryOptions('');
});

function renderCategoryOptions(selected) {
  const type = document.getElementById('ecControlType').value;
  const cats = checkpointTypeCategoryMap[type]||[];
  const sel = document.getElementById('ecCategory');
  sel.disabled = !type;
  sel.innerHTML = ['<option value="">Select checkpoint category…</option>',
    ...cats.map(c=>`<option value="${c}"${c===selected?' selected':''}>${c}</option>`)].join('');
  if (!cats.includes(selected)) sel.value='';
}

function renderStageChoices(selectedStages) {
  const el = document.getElementById('ecStageList');
  const hint = document.getElementById('ecStageHint');
  const stages = getStageUniverse(selectedEcShipType);
  if (!stages.length) {
    el.innerHTML='<div style="color:var(--muted);font-size:12px">No stages for this context.</div>';
    hint.textContent=''; return;
  }
  hint.textContent=`${stages.length} stage${stages.length===1?'':'s'} available`;
  const selSet = new Set(selectedStages);
  el.innerHTML = stages.map((s,i)=>`
    <label class="stage-choice">
      <input type="checkbox" value="${s}" ${selSet.has(s)?'checked':''}>
      <span><div class="sc-name">${i+1}. ${s}</div><div class="sc-sub">Auto-applies to matching shipments</div></span>
    </label>
  `).join('');
}

function getStageUniverse(type) {
  if (type&&type!=='__all__'&&shipmentTimelines[type]) return shipmentTimelines[type].map(s=>s.name);
  const all=new Set();
  Object.values(shipmentTimelines).forEach(sl=>sl.forEach(s=>all.add(s.name)));
  return [...all];
}

function saveCheckpoint() {
  const type = document.getElementById('ecControlType').value;
  const cat = document.getElementById('ecCategory').value;
  const details = document.getElementById('ecDetails').value.trim();
  const stages = [...document.querySelectorAll('#ecStageList input:checked')].map(i=>i.value);
  if (!type) { showToast('Please select a control type.','danger'); return; }
  if (!cat) { showToast('Please select a category.','danger'); return; }
  if (!details) { showToast('Please enter checklist details.','danger'); return; }
  if (!stages.length) { showToast('Please select at least one stage.','danger'); return; }
  const ts = getTimestamp();
  const existing = editingCpIdx!==null ? checkpointDefinitions[editingCpIdx] : null;
  const cp = {
    id: existing?.id||`CTRL-${Date.now()}-${Math.floor(Math.random()*1000)}`,
    type, category:cat, checklistDetails:details, verificationStages:stages,
    createdAt: existing?.createdAt||ts, updatedAt: ts
  };
  if (editingCpIdx===null) checkpointDefinitions.push(cp);
  else checkpointDefinitions[editingCpIdx] = cp;
  closeModal('execControlModal');
  showToast(editingCpIdx===null?'Checkpoint added ✓':'Checkpoint updated ✓','success');
  editingCpIdx=null;
  renderAll();
}

function removeCheckpoint(idx) {
  if (!confirm('Remove this checkpoint definition?')) return;
  checkpointDefinitions.splice(idx,1);
  showToast('Checkpoint removed','danger');
  renderAll();
}

function removeShipment(idx) {
  if (!confirm('Remove this shipment?')) return;
  shipments.splice(idx,1);
  showToast('Shipment removed','danger');
  renderAll();
}

function getAutoAppliedControls(shipment) {
  if (!shipment?.timeline) return [];
  const shipStages = new Set(shipment.timeline.map(s=>s.name));
  return checkpointDefinitions.map(cp=>{
    const matched = (cp.verificationStages||[]).filter(s=>shipStages.has(s));
    if (!matched.length) return null;
    return {...cp, verificationStages:matched};
  }).filter(Boolean);
}

// ═══════════════════════════════════════
// RENDER STATS
// ═══════════════════════════════════════
function renderStats() {
  const total = shipments.length;
  const cpTotal = checkpointDefinitions.length;
  const allStages = shipments.flatMap(s=>s.timeline);
  const planned = allStages.filter(s=>s.date).length;
  const coverage = shipments.reduce((acc,s)=>{
    const auto = getAutoAppliedControls(s);
    const covered = new Set(auto.flatMap(c=>c.verificationStages)).size;
    return acc+(covered>0?1:0);
  },0);
  document.getElementById('statRow').innerHTML = `
    <div class="stat-card sc-a"><div class="stat-ico">◈</div><div class="stat-lbl">Total Shipments</div><div class="stat-val">${total}</div><div class="stat-sub">Tracked</div></div>
    <div class="stat-card sc-b"><div class="stat-ico">◉</div><div class="stat-lbl">Checkpoint Definitions</div><div class="stat-val">${cpTotal}</div><div class="stat-sub">In library</div></div>
    <div class="stat-card sc-c"><div class="stat-ico">☰</div><div class="stat-lbl">Stages Planned</div><div class="stat-val">${planned}</div><div class="stat-sub">of ${allStages.length} total</div></div>
    <div class="stat-card sc-d"><div class="stat-ico">✓</div><div class="stat-lbl">Shipments w/ Checkpoints</div><div class="stat-val">${coverage}</div><div class="stat-sub">of ${total} shipments</div></div>
  `;
}

// ═══════════════════════════════════════
// RENDER ALERTS
// ═══════════════════════════════════════
function renderAlerts() {
  const now = new Date();
  const lateShipments = shipments.filter(s=>{
    const dates = s.timeline.map(t=>parseLocalDate(t.date)).filter(Boolean);
    const last = dates.length ? new Date(Math.max(...dates)) : null;
    return last && last < now;
  });
  let html='';
  if (lateShipments.length) html+=`<div class="alert alert-danger">⚠ <strong>${lateShipments.length} shipment${lateShipments.length>1?'s':''}</strong> with past delivery dates — review required</div>`;
  const noCp = shipments.filter(s=>getAutoAppliedControls(s).length===0);
  if (noCp.length && checkpointDefinitions.length>0) html+=`<div class="alert alert-warning">◐ <strong>${noCp.length} shipment${noCp.length>1?'s':''}</strong> with no checkpoint coverage</div>`;
  document.getElementById('alertBanners').innerHTML=html;
  const badge = document.getElementById('navBadgeOverdue');
  if (lateShipments.length) { badge.style.display=''; badge.textContent=lateShipments.length; }
  else badge.style.display='none';
}

// ═══════════════════════════════════════
// RENDER SHIPMENTS
// ═══════════════════════════════════════
function renderShipments() {
  const search = (document.getElementById('searchInput')?.value||'').toLowerCase();
  const filterType = document.getElementById('filterType')?.value||'';

  // Populate type filter
  const fsel = document.getElementById('filterType');
  if (fsel.children.length<=1) {
    Object.keys(shipmentTimelines).forEach(t=>{ const o=document.createElement('option'); o.value=t; o.textContent=t; fsel.appendChild(o); });
  }

  let filtered = shipments.filter(s=>{
    const ms = !search || s.id.toLowerCase().includes(search) || s.type.toLowerCase().includes(search);
    const mt = !filterType || s.type===filterType;
    const now = new Date();
    if (currentFilter==='overdue') {
      const dates = s.timeline.map(t=>parseLocalDate(t.date)).filter(Boolean);
      const last = dates.length?new Date(Math.max(...dates)):null;
      if (!last||last>=now) return false;
    }
    return ms&&mt;
  });

  const container = document.getElementById('shipmentsContainer');
  if (!filtered.length) {
    container.innerHTML=`<div class="empty-state"><div class="empty-ico">◈</div><p>${shipments.length===0?'No shipments yet. Click "+ Add Shipment" to get started.':'No shipments match your filters.'}</p></div>`;
    return;
  }

  const now = new Date();
  container.innerHTML = filtered.map((shipment,idx)=>{
    const realIdx = shipments.indexOf(shipment);
    const auto = getAutoAppliedControls(shipment);
    const dates = shipment.timeline.map(s=>parseLocalDate(s.date)).filter(Boolean);
    const firstDate = dates.length ? new Date(Math.min(...dates)) : null;
    const lastDate  = dates.length ? new Date(Math.max(...dates)) : null;
    const span = firstDate&&lastDate ? Math.max(1,daysBetween(firstDate,lastDate)+1) : 0;
    const planned = dates.length;
    const total = shipment.timeline.length;
    const pct = total ? Math.round(planned/total*100) : 0;
    const isLate = lastDate && lastDate < now;

    // Category counts for clickable pills
    const catCounts = {};
    auto.forEach(cp=>{
      const k=`${cp.type}__${cp.category||'Uncategorized'}`;
      if (!catCounts[k]) catCounts[k]={type:cp.type,category:cp.category||'Uncategorized',count:0};
      catCounts[k].count++;
    });
    const cpPills = Object.keys(catCounts).length
      ? Object.keys(catCounts).sort().map(k=>{
          const it=catCounts[k];
          return `<button type="button" class="count-pill" onclick="openCpList('${encodeURIComponent(it.type)}','${encodeURIComponent(it.category)}')">${it.type}: ${it.category} (${it.count})</button>`;
        }).join('')
      : '<span class="count-pill">No checkpoints</span>';

    // Stage checkpoint map for milestones
    const stageCheckMap={};
    auto.forEach(cp=>(cp.verificationStages||[]).forEach(s=>{
      if (!stageCheckMap[s]) stageCheckMap[s]=[];
      stageCheckMap[s].push(cp);
    }));

    const milestonesHTML = shipment.timeline.map(stage=>{
      const d = parseLocalDate(stage.date);
      const checks = stageCheckMap[stage.name]||[];
      const catGrouped = checks.reduce((a,c)=>{
        const k=`${c.type}: ${c.category||'Uncategorized'}`;
        a[k]=(a[k]||0)+1; return a;
      },{});
      const summaryPills = Object.keys(catGrouped).sort().map(k=>`<span class="mc-count">${k} (${catGrouped[k]})</span>`).join('');
      const detailItems = checks.map(c=>`<div class="mc-entry"><div class="mc-entry-title">${c.type} | ${c.category||'Uncategorized'}</div><div class="mc-entry-detail">${c.checklistDetails||'-'}</div></div>`).join('');
      return `<div class="milestone-chip" onclick="toggleMilestoneDetail(this)">
        <div class="mc-header"><span class="mc-dot"></span><span class="mc-name">${stage.name}</span></div>
        <div class="mc-date">${d?fmtDisp(d):'Date pending'}</div>
        ${summaryPills ? `<div class="mc-summary">${summaryPills}</div><div class="mc-detail-list">${detailItems}</div>` : ''}
      </div>`;
    }).join('');

    // Stage pips
    const pipColor = s => {
      const d=parseLocalDate(s.date);
      if (!d) return '';
      if (d<now) return 'done';
      return 'active';
    };
    const pipsHTML = shipment.timeline.map(s=>`<div class="stage-pip ${pipColor(s)}"></div>`).join('');

    return `<div class="shipment-card${isLate?' shipment-card--late':''}">
      <div class="ship-head">
        <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap">
          <span class="ship-id">Shipment #${shipment.id}</span>
          ${isLate?'<span style="font-size:11px;color:var(--danger);font-weight:700;background:var(--danger-bg);padding:2px 9px;border-radius:99px">Past Delivery</span>':''}
        </div>
        <div class="ship-acts">
          <button type="button" class="btn btn-ghost btn-sm" onclick="openAddShipmentModal(${realIdx})">Edit</button>
          <button type="button" class="btn btn-danger btn-sm" onclick="removeShipment(${realIdx})">Remove</button>
        </div>
      </div>
      <div class="ship-meta">
        <span class="type-pill">${shipment.type}</span>
        ${cpPills}
      </div>
      <div class="overview-grid">
        <div class="ov-item"><div class="ov-lbl">Planned Stages</div><div class="ov-val">${planned}/${total}</div></div>
        <div class="ov-item"><div class="ov-lbl">First Stage</div><div class="ov-val" style="font-size:11px">${shipment.timeline[0]?.name||'-'}</div></div>
        <div class="ov-item"><div class="ov-lbl">Last Stage</div><div class="ov-val" style="font-size:11px">${shipment.timeline[shipment.timeline.length-1]?.name||'-'}</div></div>
        <div class="ov-item"><div class="ov-lbl">Planned Span</div><div class="ov-val">${span?fmtSpan(span):'-'}</div></div>
        <div class="ov-item"><div class="ov-lbl">Auto Checkpoints</div><div class="ov-val">${auto.length}</div></div>
        <div class="ov-item"><div class="ov-lbl">CP Coverage</div><div class="ov-val">${new Set(auto.flatMap(c=>c.verificationStages)).size}/${total}</div></div>
      </div>
      <div class="prog-wrap">
        <div class="prog-labels"><span>Stage Progress</span><strong>${pct}%</strong></div>
        <div class="stage-pips">${pipsHTML}</div>
        <div class="prog-track"><div class="prog-fill" style="width:${pct}%"></div></div>
      </div>
      <div class="sec-label">Milestones</div>
      <div class="milestones-row">${milestonesHTML}</div>
    </div>`;
  }).join('');
}

function toggleMilestoneDetail(chip) {
  const list = chip.querySelector('.mc-detail-list');
  const summary = chip.querySelector('.mc-summary');
  if (!list) return;
  const hidden = list.style.display===''||list.style.display==='none';
  list.style.display = hidden?'block':'none';
  if (summary) summary.style.display = hidden?'none':'flex';
}

// ═══════════════════════════════════════
// RENDER CHECKPOINT LIBRARY
// ═══════════════════════════════════════
function renderCpLibrary() {
  const count = checkpointDefinitions.length;
  document.getElementById('cpCountLabel').textContent=`${count} checkpoint${count===1?'':'s'}`;
  const body = document.getElementById('cpLibBody');
  if (!count) {
    body.innerHTML=`<div class="empty-state"><div class="empty-ico">◉</div><p>No checkpoints defined yet. Click "+ Add" to create one.</p></div>`;
    return;
  }
  body.innerHTML = checkpointDefinitions.map((cp,i)=>`
    <div class="cp-card" onclick="openCheckpointModal(${i})">
      <div class="cp-head">
        <div class="cp-title">${cp.type} | ${cp.category||'Uncategorized'}</div>
        <div class="cp-acts">
          <button type="button" class="btn btn-ghost btn-sm" onclick="event.stopPropagation();openCheckpointModal(${i})">Edit</button>
          <button type="button" class="btn btn-danger btn-sm" onclick="event.stopPropagation();removeCheckpoint(${i})">Remove</button>
        </div>
      </div>
      <div class="cp-meta">
        <span class="cp-pill">Created ${cp.createdAt||'-'}</span>
        <span class="cp-pill">Updated ${cp.updatedAt||'-'}</span>
      </div>
      <div class="cp-detail">${cp.checklistDetails||'-'}</div>
      <div class="cp-vl">Mapped Stages</div>
      <div class="cp-stages">${(cp.verificationStages||[]).map(s=>`<span class="stage-tag">${s}</span>`).join('')}</div>
    </div>
  `).join('');
}

// ═══════════════════════════════════════
// CHECKPOINT LIST MODAL (from shipment pills)
// ═══════════════════════════════════════
function openCpList(encType, encCat) {
  const type=decodeURIComponent(encType), cat=decodeURIComponent(encCat);
  const matches=checkpointDefinitions.filter(cp=>(cp.type||'')===type&&(cp.category||'Uncategorized')===cat);
  if (!matches.length) { showToast('No checkpoint details found.','danger'); return; }
  document.getElementById('cpListTitle').textContent=`${type} — ${cat}`;
  document.getElementById('cpListSubtitle').textContent=`${matches.length} checkpoint${matches.length===1?'':'s'} mapped`;
  document.getElementById('cpListBody').innerHTML=matches.map(cp=>`
    <div class="cp-list-item">
      <div class="cp-list-title">${cp.type} | ${cp.category||'Uncategorized'}</div>
      <div class="cp-list-detail">${cp.checklistDetails||'-'}</div>
      <div class="cp-list-stages">${(cp.verificationStages||[]).map(s=>`<span class="stage-tag">${s}</span>`).join('')}</div>
    </div>
  `).join('');
  openModal('cpListModal');
}

window.openCpList = openCpList;

// ═══════════════════════════════════════
// EXPORT CSV
// ═══════════════════════════════════════
function exportCSV() {
  if (!shipments.length) { showToast('No shipments to export.','danger'); return; }
  const rows = [['Shipment ID','Type','Stage Name','Stage Date','Auto Checkpoints','Stage Coverage']];
  shipments.forEach(s=>{
    const auto = getAutoAppliedControls(s);
    const stageCheckMap={};
    auto.forEach(cp=>(cp.verificationStages||[]).forEach(st=>{
      if (!stageCheckMap[st]) stageCheckMap[st]=0;
      stageCheckMap[st]++;
    }));
    s.timeline.forEach(stage=>{
      rows.push([s.id, s.type, stage.name, stage.date||'', auto.length, stageCheckMap[stage.name]||0]);
    });
  });
  const csv=rows.map(r=>r.map(v=>`"${String(v).replace(/"/g,'""')}"`).join(',')).join('\n');
  const a=document.createElement('a');
  a.href=URL.createObjectURL(new Blob([csv],{type:'text/csv'}));
  a.download=`PGP-Shipments-${fmtInput(new Date())}.csv`;
  a.click();
  showToast('CSV exported ✓','success');
}

// ═══════════════════════════════════════
// TOAST
// ═══════════════════════════════════════
// showToast defined in common.js

// ═══════════════════════════════════════
// WIRE UP BUTTONS
// ═══════════════════════════════════════
['openAddShipBtn','openAddShipBtn2'].forEach(id=>{
  document.getElementById(id)?.addEventListener('click',()=>openAddShipmentModal());
});
['openExecModalBtn','openExecModalBtn2','openExecModalBtn3'].forEach(id=>{
  document.getElementById(id)?.addEventListener('click',()=>openCheckpointModal());
});

// ═══════════════════════════════════════
// PERSIST DATA TO SERVER (ViewState via async UpdatePanel postback)
// ═══════════════════════════════════════
function persistData() {
  try {
    document.getElementById('<%= hfShipments.ClientID %>').value   = JSON.stringify(shipments);
    document.getElementById('<%= hfCheckpoints.ClientID %>').value = JSON.stringify(checkpointDefinitions);
    __doPostBack('<%= btnSave.UniqueID %>', '');
  } catch(e) {
    console.warn('Could not persist data:', e);
  }
}

// ═══════════════════════════════════════
// RENDER ALL
// ═══════════════════════════════════════
function renderAll() {
  persistData();
  renderStats();
  renderAlerts();
  renderShipments();
  renderCpLibrary();
  const nb=document.getElementById('navBadgeAll');
  if (shipments.length) { nb.style.display=''; nb.textContent=shipments.length; }
  else nb.style.display='none';
}

// Init
renderAll();

// Tawk.to
var Tawk_API=Tawk_API||{},Tawk_LoadStart=new Date();
(function(){
  var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
  s1.async=true;s1.src='https://embed.tawk.to/69bdae15cfaccd1c35824e9a/1jk6f02al';
  s1.charset='UTF-8';s1.setAttribute('crossorigin','*');
  s0.parentNode.insertBefore(s1,s0);
})();
</script>
</form>
</body>
</html>
