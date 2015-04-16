angular.module("SharedServices").service("TimeUtil", [() ->
    this.timeSince1970InSeconds = () ->
        new Date().getTime() / 1000.0

    this.timeFromTimestampInSeconds = (timestamp) ->
        Date.parse(timestamp) / 1000.0

    this.timeIntervalAsString = (timeIntervalMs) ->
        if timeIntervalMs < 60
            return "A moment"
        if timeIntervalMs >= 31536000
            return "An eternity"

        value = 0
        unit = ""
        if timeIntervalMs < 3600
            value = Math.round(timeIntervalMs / 60.0)
            unit = "minute"
        else if timeIntervalMs < 86400
            value = Math.round(timeIntervalMs / 3600.0)
            unit = "hour"
        else if timeIntervalMs < 2592000
            value = Math.round(timeIntervalMs / 86400.0)
            unit = "day"
        else
            value = Math.round(timeIntervalMs / 2592000.0)
            unit = "month"

        return if value == 1 then "1 #{unit}" else "#{value} #{unit}s"

    return
])
