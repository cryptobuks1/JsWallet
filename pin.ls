require! {
    \localStorage
    \crypto-js/md5 : md5
    \./seed-encrypt.ls
}
mem = 
    encrypt: null
get-key = (value)->
    value + 'cb562eb3-c442-4866-a1a9-70a9'
export del = ->
    local-storage.set-item \spin, ""
export setbkp =->
    local-storage.set-item \spinbkp, local-storage.get-item(\spin)
export set = (value)->
    key = get-key value
    res = seed-encrypt.encrypt(value, key)
    local-storage.set-item \spin, res
export exists = ->
    (local-storage.get-item(\spin) ? "") isnt ""
export encrypt = (str)->
    return mem.encrypt(str) if typeof! mem.encrypt is \Function
    \unsecure
export check = (value)->
    return no if typeof! value isnt \String
    return no if value.length < 4
    mem.encrypt = (str)->
        md5(value + '234ef' + str).toString!
    res = local-storage.get-item(\spin) ? ""
    return no if res.length is 0
    key = get-key value
    decrypted = seed-encrypt.decrypt(res, key)
    decrypted is value