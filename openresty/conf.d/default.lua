-- 用户跟踪cookie名为__utrace
local uid = ngx.var.cookie___utrace
if not uid then
    -- 如果没有则生成一个跟踪cookie，算法为md5(时间戳+IP+客户端信息)
    uid = ngx.md5(ngx.now() .. ngx.var.remote_addr .. ngx.var.http_user_agent)
end
ngx.header['Set-Cookie'] = { '__utrace=' .. uid .. '; path=/' }
if ngx.var.arg_domai then
    -- 通过subrequest到/i-log记录日志，将参数和用户跟踪cookie带过去
    ngx.location.capture('/i-log?' .. ngx.var.args .. '&utrace=' .. uid)
end
