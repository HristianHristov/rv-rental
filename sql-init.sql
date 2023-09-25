CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    first_name text,
    last_name text
);

CREATE TABLE IF NOT EXISTS rentals (
    id SERIAL PRIMARY KEY,
    user_id integer,
    name text,
    type text,
    description text,
    sleeps integer,
    price_per_day bigint,
    home_city text,
    home_state text,
    home_zip text,
    home_country text,
    vehicle_make text,
    vehicle_model text,
    vehicle_year integer,
    vehicle_length numeric(4,2),
    created timestamp with time zone,
    updated timestamp with time zone,
    lat double precision,
    lng double precision,
    primary_image_url text
);

CREATE OR REPLACE FUNCTION haversine(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric)
  RETURNS numeric AS
$$
DECLARE
  dLat numeric;
  dLon numeric;
  a numeric;
  c numeric;
  distance numeric;
BEGIN
  -- Convert latitude and longitude from degrees to radians
  lat1 := radians(lat1);
  lon1 := radians(lon1);
  lat2 := radians(lat2);
  lon2 := radians(lon2);

  -- Haversine formula
  dLat := lat2 - lat1;
  dLon := lon2 - lon1;
  a := sin(dLat / 2)^2 + cos(lat1) * cos(lat2) * sin(dLon / 2)^2;
  c := 2 * atan2(sqrt(a), sqrt(1 - a));
  distance := 6371 * c; -- Earth's radius in kilometers

  RETURN distance;
END;
$$
LANGUAGE plpgsql;


INSERT INTO "users"("id", "first_name", "last_name")
VALUES
    (1, 'John', 'Smith'),
    (2, 'Jane', 'Doe'),
    (3, 'Barry', 'Martin'),
    (4, 'Todd', 'Edison'),
    (5, 'Ben', 'Reynard')
;

INSERT INTO "rentals"("user_id", "name","type","description","sleeps","price_per_day","home_city","home_state","home_zip","home_country","vehicle_make","vehicle_model","vehicle_year","vehicle_length","created","updated","lat","lng","primary_image_url")
VALUES
(1, E'\'Abaco\' VW Bay Window: Westfalia Pop-top',E'camper-van',E'ultrices consectetur torquent posuere phasellus urna faucibus convallis fusce sem felis malesuada luctus diam hendrerit fermentum ante nisl potenti nam laoreet netus est erat mi',4,16900,E'Costa Mesa',E'CA',E'92627',E'US',E'Volkswagen',E'Bay Window',1978,15,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',33.64,-117.93,E'https://res.cloudinary.com/outdoorsy/image/upload/v1528586451/p/rentals/4447/images/yd7txtw4hnkjvklg8edg.jpg'),
(2, E'Maupin: Vanagon Camper',E'camper-van',E'fermentum nullam congue arcu sollicitudin lacus suspendisse nibh semper cursus sapien quis feugiat maecenas nec turpis viverra gravida risus phasellus tortor cras gravida varius scelerisque',4,15000,E'Portland',E'OR',E'97202',E'US',E'Volkswagen',E'Vanagon Camper',1989,15,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',45.51,-122.68,E'https://res.cloudinary.com/outdoorsy/image/upload/v1498568017/p/rentals/11368/images/gmtye6p2eq61v0g7f7e7.jpg'),
(3, E'1984 Volkswagen Westfalia',E'camper-van',E'urna iaculis sed ut porttitor mollis ante cubilia ad felis duis varius mollis nascetur metus faucibus ligula ultricies in faucibus morbi imperdiet auctor morbi torquent',4,18000,E'San Diego',E'CA',E'92037',E'US',E'Volkswagen',E'Westfalia',1984,16,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',32.83,-117.28,E'https://res.cloudinary.com/outdoorsy/image/upload/v1504395813/p/rentals/21399/images/nxtwdubpapgpmuc65pd1.jpg'),
(4, E'Sm. #1 (Sleeps 2) - Check Dates for Price',E'camper-van',E'aliquet sit placerat libero viverra hendrerit ridiculus etiam pulvinar faucibus tempor magnis litora neque varius volutpat mollis class laoreet quisque montes cubilia leo aliquet litora',2,8900,E'Salt Lake City',E'UT',E'84104',E'US',E'Ford',E'Transit 350',2016,19,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',40.73,-111.92,E'https://res.cloudinary.com/outdoorsy/image/upload/v1508688886/p/rentals/25403/images/jkqxknddnuq6fvmyatke.jpg'),
(5, E'Stardust2005Mercedes-BenzSprinter',E'camper-van',E'pretium sit in quis semper ligula sed sagittis molestie et vehicula cursus ullamcorper est euismod diam massa sem cum lorem cursus euismod vivamus urna leo',4,8000,E'San Diego',E'CA',E'92109',E'US',E'Mercedes-Benz',E'Sprinter',2005,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',32.8,-117.24,E'https://res.cloudinary.com/outdoorsy/image/upload/v1521261348/p/rentals/40129/images/wn0tx6meifqtrnwjmeoq.jpg'),
(1, E'2003 Winnebago Eurovan Camper Eurovan Camper',E'camper-van',E'eros tellus quisque tellus parturient elit varius maecenas justo aliquet metus neque sociis interdum commodo curae class leo massa cursus auctor nisl ante semper habitant',4,13000,E'Charleston',E'SC',E'29412',E'US',E'Winnebago Eurovan Camper',E'Eurovan Camper',2003,17,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',32.69,-79.96,E'https://res.cloudinary.com/outdoorsy/image/upload/v1523649590/p/rentals/46190/images/elinlzv6fpnrktik4wqh.jpg'),
(2, E'2002 Volkswagen Eurovan Weekender Westfalia',E'camper-van',E'purus neque pellentesque potenti posuere molestie vivamus urna faucibus class justo porta litora turpis cubilia sit class torquent ullamcorper netus ut sapien libero consequat quisque',4,15000,E'Rancho Mission Viejo',E'CA',E'',E'US',E'VW',E'Eurovan Weekender Westfalia',2002,0,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',33.53,-117.63,E'https://res.cloudinary.com/outdoorsy/image/upload/v1526614056/p/rentals/52210/images/nou2lx0h0dsjzbqeotuf.jpg'),
(3, E'2017 Transit Adventure Van',E'camper-van',E'commodo congue platea magnis montes feugiat lorem metus nullam ante convallis nulla dolor mauris praesent mus ante varius per hac sed metus auctor ultricies diam',2,16500,E'Sacramento',E'CA',E'95811',E'US',E'Ford',E'Sacramento',2017,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',38.57,-121.49,E'https://res.cloudinary.com/outdoorsy/image/upload/v1562023338/p/rentals/119031/images/wchguimw6h3u9oonba9b.jpg'),
(4, E'Maui "Alani" camping car SUBARU IMPREZA 4WD  -Cold AC.',E'camper-van',E'fermentum torquent hac id tortor conubia litora proin sociosqu congue elit ridiculus fames velit viverra faucibus eleifend sagittis etiam aptent sociosqu taciti metus iaculis quam',2,5900,E'Kahului',E'HI',E'96732',E'US',E'SUBARU IMPREZA 4WD',E'SUBARU IMPREZA 4WD',2003,13,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',20.88,-156.45,E'https://res.cloudinary.com/outdoorsy/image/upload/v1538027810/p/rentals/82458/images/bphrohl2r4wxc8wg3v11.jpg'),
(5, E'Betty!    1987 Volkswagen Westfalia Poptop Manual with kitchen!',E'camper-van',E'mollis curabitur cum convallis sagittis feugiat lectus ligula porta libero parturient maecenas cum facilisis ridiculus mauris ut est scelerisque tincidunt quisque hac lectus mus dapibus',4,25000,E'Missoula ',E'MT',E'59808',E'US',E'Volkswagen',E'Westfalia',1987,15,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',46.92,-114.09,E'https://res.cloudinary.com/outdoorsy/image/upload/v1535836865/p/rentals/91133/images/blijuwlisflua72ay1p2.jpg'),
(1, E'Daisy',E'camper-van',E'varius hendrerit turpis risus vivamus lectus primis taciti quam pharetra montes sapien facilisi aliquam nullam cras amet fringilla tortor interdum netus libero euismod dictumst auctor',4,8900,E'Bangor',E'',E'BT23 7XE',E'IE',E'Volkswagen',E'Campervan',1979,4,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',54.63,-5.67,E'https://res.cloudinary.com/outdoorsy/image/upload/v1548176735/p/rentals/105564/images/lwm0elb5mzs8m7gqxjta.jpg'),
(2, E'*ESSENTIAL WORKERS - Pearl - The Maui Camping Cruiser',E'camper-van',E'malesuada neque velit leo pharetra magnis lectus sapien turpis aenean eu blandit per mi accumsan cursus porta conubia per tellus et morbi dictumst et arcu',2,3000,E'Kihei',E'HI',E'96753',E'US',E'Ford',E'Other',2010,17,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',20.77,-156.45,E'https://res.cloudinary.com/outdoorsy/image/upload/v1550269521/p/rentals/108507/images/zlruuz6ll72taorfwjs1.jpg'),
(3, E'The Coolest Camper Van Around',E'camper-van',E'porta eros bibendum cum bibendum purus aliquet dis augue litora tempus ridiculus ornare tempor nascetur tristique mauris aenean vehicula maecenas facilisi sociis ut parturient vel',4,7900,E'Provo',E'UT',E'84601',E'US',E'Dodge',E'B Van',2000,16,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',40.24,-111.7,E'https://res.cloudinary.com/outdoorsy/image/upload/v1556142483/p/rentals/109101/images/ea2vvbovq0tvouj00fad.jpg'),
(4, E'Ford Transit Campervan',E'camper-van',E'venenatis aliquam suspendisse odio tortor purus quis eros scelerisque congue per et justo adipiscing montes sed dignissim risus facilisis hac nostra porta hendrerit rhoncus semper',2,23900,E'Calgary',E'AB',E'T3N 1N8',E'CA',E'Ford',E'Transit 250',2019,22,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',51.15,-113.98,E'https://res.cloudinary.com/outdoorsy/image/upload/v1554872873/p/rentals/115462/images/qnsbiznxh9hxttrlmwuq.jpg'),
(5, E'AWESOME 1977 Volkswagen Westfalia camper',E'camper-van',E'lorem in feugiat eleifend sem semper aenean sociis eros fusce et venenatis turpis tempor suscipit inceptos turpis parturient himenaeos libero non quis lobortis fames velit',4,9900,E'Los Angeles',E'CA',E'90023',E'US',E'Volkswagen',E'Westfalia',1977,15,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',34.02,-118.21,E'https://res.cloudinary.com/outdoorsy/image/upload/v1558048520/p/rentals/119960/images/sceobzuac0stwyrndi2z.jpg'),
(1, E'Ford Transit Camper Van',E'camper-van',E'et tempus sagittis senectus viverra hendrerit vitae pretium parturient commodo senectus hac volutpat quam nam lacus purus ridiculus consequat nascetur metus curabitur turpis cursus bibendum',4,20000,E'Portland',E'OR',E'97220',E'US',E'Ford',E'Van',2018,19,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',45.53,-122.58,E'https://res.cloudinary.com/outdoorsy/image/upload/v1558102819/p/rentals/120853/images/lmx0f2klrsdbmmuhflvm.jpg'),
(2, E'4Runner TRD Pro - 1',E'camper-van',E'parturient aenean mollis feugiat suscipit montes est duis aptent nostra vehicula nostra nulla ullamcorper fermentum varius in etiam accumsan morbi nibh mauris praesent placerat enim',2,19900,E'GLENWOOD SPRINGS',E'CO',E'81601',E'US',E'Toyota',E'4Runner',2017,16,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',39.55,-107.33,E'https://res.cloudinary.com/outdoorsy/image/upload/v1572716112/p/rentals/122562/images/kzprabntk4n67lclikqf.jpg'),
(3, E'2007 toyota 4RUNNER',E'camper-van',E'proin a et enim quisque fermentum elit proin ultricies tellus donec iaculis id posuere facilisi sapien lorem suspendisse facilisis morbi placerat donec praesent nostra luctus',4,13500,E'Anchorage',E'AK',E'99504',E'US',E'toyota',E'4RUNNER',2007,16,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',61.19,-149.73,E'https://res.cloudinary.com/outdoorsy/image/upload/v1561148804/p/rentals/127213/images/tlbmzttamvxtyedkj59e.jpg'),
(4, E'Big Blue The Adventure Van',E'camper-van',E'proin ligula dolor lorem ad velit est tempus taciti platea sociosqu semper imperdiet viverra a bibendum ullamcorper commodo sapien himenaeos mattis pulvinar primis congue eros',3,13000,E'Phoenix',E'AZ',E'85048',E'US',E'Ford',E'Transit',2015,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',33.3,-112.06,E'https://res.cloudinary.com/outdoorsy/image/upload/v1565039202/p/rentals/135075/images/qzshxyzofqz6bawudfd2.jpg'),
(5, E'The Getaway Van',E'camper-van',E'torquent tortor litora tincidunt odio facilisis sem cubilia nisl sollicitudin molestie blandit pellentesque fermentum aliquet magnis pulvinar tempus auctor scelerisque vel erat pulvinar egestas mus',2,12900,E'Ewa Beach',E'HI',E'96706',E'US',E'Chevrolet',E'Other',2002,19,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',21.32,-157.98,E'https://res.cloudinary.com/outdoorsy/image/upload/v1567092673/p/rentals/137341/images/ms68oj41vlzuehoohy7u.jpg'),
(1, E'2013 Peugeot Expert SWB',E'camper-van',E'sem vitae bibendum hendrerit sapien nulla convallis tempus gravida eu libero litora vulputate tempus nulla ac molestie consequat dictum nisl aptent ligula lacus senectus sagittis',2,9000,E'Cumbria',E'CMA',E'CA11 9TE',E'GB',E'Peugeot',E'Expert SWB',2015,4.8,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',54.72,-2.88,E'https://res.cloudinary.com/outdoorsy/image/upload/v1566292990/p/rentals/137450/images/m1axdiiyampit2da6ufu.jpg'),
(2, E'2007 Dodge Sprinter 2500 170ext',E'camper-van',E'condimentum ipsum a pretium condimentum erat vel praesent porttitor auctor morbi eleifend maecenas sem dignissim risus orci nulla diam ultricies orci natoque phasellus commodo vehicula',2,14900,E'Denver',E'CO',E'80238',E'US',E'Dodge',E'Sprinter 2500 170ext',2007,22,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',39.8,-104.89,E'https://res.cloudinary.com/outdoorsy/image/upload/v1566599922/p/rentals/138114/images/ab2mosnnlfudkxhqgqcy.jpg'),
(3, E'2002 Chevrolet Van Conversion',E'camper-van',E'magnis interdum morbi faucibus habitasse sapien porta iaculis platea mi proin posuere vel ligula curabitur amet vehicula amet condimentum ridiculus diam diam proin est etiam',2,9900,E'San Diego',E'CA',E'92107',E'US',E'Chevrolet',E'Express',2002,21,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',32.73,-117.24,E'https://res.cloudinary.com/outdoorsy/image/upload/v1569722222/p/rentals/143740/images/ooxoce0zrlycj5esm3jh.png'),
(4, E'2017 Ford Transit',E'camper-van',E'odio fermentum risus montes sapien ullamcorper quam facilisi sociis ultrices facilisis pulvinar magnis id cursus at quam sapien fringilla auctor tempus porta cursus sagittis eget',1,10500,E'Edmonton',E'AB',E'T5T 6V2',E'CA',E'Ford',E'Transit',2017,5,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',53.52,-113.68,E'https://res.cloudinary.com/outdoorsy/image/upload/v1571422978/p/rentals/145653/images/cy74icmc2qj0oo6zkgqe.jpg'),
(5, E'TiKi Van  Extended custom camper',E'camper-van',E'molestie aptent ullamcorper dui ultricies ultricies montes dictum non nulla velit vulputate accumsan aliquam nunc per id vehicula hac etiam habitasse posuere praesent erat tincidunt',3,12000,E'Keaau',E'HI',E'96749',E'US',E'Ford',E'Econolline 250s',2003,19,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',19.57,-155.01,E'https://res.cloudinary.com/outdoorsy/image/upload/v1571732982/p/rentals/145954/images/gj4muh11n0rbxi8y3b47.jpg'),
(1, E'2013 Toyota Hiace Campervan. 5 Seater Automatic. Immaculate Condition..',E'camper-van',E'mi proin donec mauris dolor ipsum ridiculus dictumst nisl leo semper ipsum diam id congue tortor curabitur curae adipiscing odio amet posuere commodo orci semper',5,11000,E'Mount Pleasant',E'WA',E'6153',E'AU',E'Toyota',E'Hiace Campervan. 5 Seater Automatic Great Condition..',2013,6,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',-32.02,115.84,E'https://res.cloudinary.com/outdoorsy/image/upload/v1572098257/p/rentals/146330/images/p4yes9tepvixnlcz4ick.jpg'),
(2, E'Coya | Van-gelina Jolie',E'camper-van',E'lacus cras molestie nam dapibus ullamcorper massa ultricies bibendum lectus auctor nisi ridiculus ultricies tristique curabitur diam feugiat erat inceptos sapien vivamus parturient sem nibh',2,20000,E'Seattle',E'WA',E'98116',E'US',E'Ford',E'Transit',2019,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',47.56,-122.39,E'https://res.cloudinary.com/outdoorsy/image/upload/v1582091293/p/rentals/153401/images/kaqt2b6n6sm1xnmvbi5w.jpg'),
(3, E'sCAMPer X',E'camper-van',E'ac tellus phasellus ultrices nostra eros aenean metus ridiculus adipiscing habitant nulla cubilia tortor rhoncus quisque sem ultrices varius massa mollis congue praesent nam ante',4,17500,E'Atlanta',E'GA',E'30310',E'US',E'Ram',E'Promaster',2020,19,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',33.73,-84.41,E'https://res.cloudinary.com/outdoorsy/image/upload/v1589910541/p/rentals/156152/images/jvyvtqoeljadoizjjzag.jpg'),
(4, E'2015 Dodge Sprinter Van',E'camper-van',E'pretium non litora lobortis pharetra elit sociosqu platea nostra interdum odio vestibulum tincidunt mi blandit convallis pellentesque tempor viverra fermentum ultricies nunc egestas id arcu',2,17000,E'Silverthorne',E'CO',E'80498',E'US',E'Dodge',E'Sprinter Van',2015,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',39.62,-106.09,E'https://res.cloudinary.com/outdoorsy/image/upload/v1588550855/p/rentals/162781/images/az0xp8wbdto4pjzlkyh3.jpg'),
(5, E'The New Adventures of Pearl - 2014 Nissan NV2500 High Top',E'camper-van',E'malesuada eget conubia porta sollicitudin urna ad aenean lacus vulputate parturient vulputate suspendisse sit parturient ante mauris maecenas dignissim donec eget adipiscing dui luctus eget',2,18900,E'Denver',E'CO',E'80222',E'US',E'Nissan',E'NV2500',2014,20,E'2021-11-29 22:42:06.478595+00',E'2021-11-29 22:42:06.478595+00',39.67,-104.92,E'https://res.cloudinary.com/outdoorsy/image/upload/v1590500837/undefined/rentals/164961/images/t3nkxdl0ua8g6gp1idcm.jpg');