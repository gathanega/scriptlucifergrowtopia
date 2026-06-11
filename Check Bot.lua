sep           = "|"     --Name Pass Separator
listFile      = "clear.txt" --Bot List name{sep}pass / name|pass
onlineBotFile = "done.txt"

function serialize_bot_name(bot_name)
    local struct_bot = {
        nama = "",
        kata_sandi = ""
    }
    struct_bot.nama, struct_bot.kata_sandi = bot_name:match("([^|]+)" .. sep .. "([^|]+)")
    return struct_bot
end

function checkStatus()
    statusList = {
        account_banned              = BotStatus.account_banned,
        wrong_password              = BotStatus.wrong_password,
        captcha_requested           = BotStatus.captcha_requested,
        advanced_account_protection = BotStatus.advanced_account_,
        bad_name_length             = BotStatus.bad_name,
        invalid_account             = BotStatus.invalid_account
    }
    for status, number in pairs(statusList) do
        if getBot().status == number then
            print(name.."|"..pass.. "|bot is error|".. status)
            return true
        end
    end
    return false
end

for line in io.lines(listFile) do
    name, pass = serialize_bot_name(line).nama, serialize_bot_name(line).kata_sandi

    getBot():updateBot(name, pass)
    --getBot():updateUbiBot(name, pass, "",true)
    getBot().auto_reconnect = true
    while getBot().status ~= BotStatus.online do
        sleep(500)
        if checkStatus() then
            goto pass
        end
        if getBot().status == BotStatus.online then
            sleep(10000)
            if onlineBotFile ~= "" then
                print(name.."|"..pass.. "|level_"..getBot().level.."|age_"..getBot():getAge())
                append(onlineBotFile, name..sep..pass..sep.. "level_"..getBot().level..sep.."age_"..getBot():getAge().."\n")
            end
            goto pass
        end
    end

    ::pass::
    
    getBot():updateBot("DUMMY", "pass")
    getBot().auto_reconnect = false
end