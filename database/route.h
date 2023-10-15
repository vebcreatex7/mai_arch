#ifndef ROUTE_H
#define ROUTE_H

#include <optional>
#include <string>
#include <vector>
#include "Poco/JSON/Object.h"

namespace database {
    class Route {
    private:
        std::string _from;
        std::string _to;
        std::string _duration;
        double _distance;

    public:
        static void init();
        Route fromJSON(const std::string& str);
        Poco::JSON::Object::Ptr toJSON();

        std::string& from();
        std::string &to();

         void save_to_db();
        static std::vector<Route> get_by_user_id(long user_id);
        static Route get(long id);
    };
}

#endif 