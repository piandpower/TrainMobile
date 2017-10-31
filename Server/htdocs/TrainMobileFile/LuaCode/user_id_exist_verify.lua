package.path = 'D:/Program Files (x86)/HTTPD/htdocs/TrainMobileFile/LuaCode/lib/?.lua'
require 'string'
local fs = require 'file_system'

--get infomation of specific user
--url format: fs_user_id_exist_verify.php?id=qianqian

function handle(r)
    r.content_type = "text/plain"
    if r.method == 'GET' or r.method == 'POST' then
        local base_path = fs.getBaseDataFilePath()
        local reg_table = {}
        for k, v in pairs( r:parseargs() ) do
            reg_table[k] = v
        end

        if nil == reg_table["id"] then 
            r:puts("{\"result\":\"Unsupported http method.id should be here.\",\"code\":0,\"method\":\"user_id_exist_verify\"}")
            r.status = 405
            return apache2.OK
        end

        local user_file_path = base_path.."users/user_"..reg_table["id"]..".json"
        if false == fs.fileExists(user_file_path) then
            r:puts("{\"result\":\"user not exist.\",\"id\":\""..reg_table["id"].."\",\"code\":0,\"method\":\"user_id_exist_verify\"}")
        else
            r:puts("{\"result\":\"user exist.\",\"id\":\""..reg_table["id"].."\",\"code\":1,\"method\":\"user_id_exist_verify\"}")
        end
    elseif r.method == 'PUT' then
-- use our own Error contents
        r:puts("{\"result\":\"Unsupported http method.\",\"code\":0,\"method\":\"user_id_exist_verify\"}")
        r.status = 405
        return apache2.OK
    else
-- use the ErrorDocument
        return 501
    end
    return apache2.OK
end
