queryPreSave = (userId, changes) ->

share.Queries.before.insert (userId, query) ->
  query._id = query._id || Random.id()
  now = new Date()
  _.defaults(query,
    name: ""
    string: ""
    cmd: ""
    startDateEnabled: false
    startDate: ""
    endDateEnabled: false
    endDate: ""
    sensorEnabled: false
    sensor: ""
    typesEnabled: true
    types: []
    daddressEnabled: false
    daddress: ""
    saddressEnabled: false
    saddress: ""
    anyAddressEnabled: false
    anyAddress: ""
    dipSetEnabled: false
    dipSet: null
    sipSetEnabled: false
    sipSet: null
    anySetEnabled: false
    anySet: null
    dportEnabled: false
    dport: ""
    sportEnabled: false
    sport: ""
    aportEnabled: false
    aport: ""
    dccEnabled: false
    dcc: ""
    sccEnabled: false
    scc: ""
    protocolEnabled: false
    protocol: ""
    flagsAllEnabled: false
    flagsAll: ""
    additionalParametersEnabled: false
    additionalParameters: ""
    fields: ["sIP", "dIP", "sPort", "dPort", "protocol", "packets", "bytes", "flags", "sTime", "dur", "eTime", "sensor"]
    fieldsOrder: share.rwcutFields
    result: ""
    isStale: false
    interface: "cmd"
    isUTC: true
    isQuick: false
    isNew: true
    ownerId: userId
    updatedAt: now
    createdAt: now
  , share.queryResetValues)
  if not query.name
    prefix = "New query"
    count = share.Queries.find({ name: { $regex: "^" + prefix, $options: "i" } }).count()
    query.name = prefix
    if count
      query.name += " (" + count + ")"
  queryPreSave.call(@, userId, query)

share.Queries.before.update (userId, query, fieldNames, modifier, options) ->
  now = new Date()
  modifier.$set = modifier.$set or {}
  modifier.$set.updatedAt = modifier.$set.updatedAt or now
  queryPreSave.call(@, userId, modifier.$set)

share.queryResetValues =
  startRecNum: 1
  sortField: ""
  sortReverse: true
