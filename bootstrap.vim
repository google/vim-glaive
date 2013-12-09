let s:thisplugin = expand('<sfile>:p:h')
if !exists('*maktaba#compatibility#Disable')
  try
    " To check if Maktaba is loaded we must try calling a maktaba function.
    " exists() is false for autoloadable functions that are not yet loaded.
    call maktaba#compatibility#Disable()
  catch /E117:/
    " Maktaba is not installed. Check whether it's in a nearby directory.
    let s:rtpsave = &runtimepath
    " We'd like to use maktaba#path#Join, but maktaba doesn't exist yet.
    let s:slash = exists('+shellslash') && !&shellslash ? '\' : '/'
    let s:pathguess = fnamemodify(s:thisplugin, ':h') . s:slash . 'maktaba'
    let &runtimepath .= ',' . s:pathguess
    try
      " If we've just installed maktaba, we need to make sure that vi
      " compatibility mode is off. Maktaba does not support vi compatibility.
      call maktaba#compatibility#Disable()
    catch /E117:/
      " No luck.
      let &runtimepath = s:rtpsave
      unlet s:rtpsave
      " We'd like to use maktaba#error#Shout, but maktaba doesn't exist yet.
      echohl ErrorMsg
      echomsg 'Maktaba not found! Glaive depends upon maktaba. Please either:'
      " TODO(nates): Add a maktaba URL when there is one.
      echomsg '1. Place maktaba in the same directory as this plugin.'
      echomsg '2. Add maktaba to your runtimepath before using this plugin.'
      echohl NONE
      finish
    endtry
  endtry
endif
let s:plugin = maktaba#plugin#GetOrInstall(s:thisplugin)
call s:plugin.Load('commands')
