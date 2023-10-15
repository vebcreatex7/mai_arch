#ifndef TRIP_H
#define TRIP_H

#include <optional>
#include <string>
#include <vector>
#include "Poco/JSON/Object.h"
#include "Poco/Data/Date.h"
#include "user.h"
#include "route.h"

namespace database {
    class Trip {
    private:
        Poco::Data::Date _date;
        long _route_id;
        Route _route;
        std::vector<User> _users;

    public:
        Poco::JSON::Object::Ptr toJSON();

        Poco::Data::Date& date();
        long& route_id();
        Route& route();
        std::vector<User>& users();

        void create();
        void add_user(long user_id);
        static std::optional<Trip> get(long id);
    };
}

#endif