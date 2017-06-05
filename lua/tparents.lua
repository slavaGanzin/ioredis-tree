local function parents(id)
  local p = {}
  for _, v in ipairs(redis.call('smembers', prefix .. id  .. '::P')) do
    table.insert(p,v)
    table.insert(p, parents(v))
  end
  return p
end

if ARGV[2] == 'ALL' then
  return parents(id)
else
  return redis.call('smembers', key .. '::P')
end
