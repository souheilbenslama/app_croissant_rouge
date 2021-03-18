
class Region {
  String region;
  String lat;
  String lng;
  String population;
  String confirmed;
  String sick;
  String recovered;
  String id;
}

const data =  [
    {
      "region": "Tunis",
      "lat": "36.8008",
      "lng": "10.18",
      "population": "1056247",
      "confirmed": "31687",
      "sick": "95062",
      "recovered": "25350",
      "id": "1"
    },
    {
      "region": "Sfax",
      "lat": "34.75",
      "lng": "10.72",
      "population": "955421",
      "confirmed": "28663",
      "sick": "85988",
      "recovered": "22930",
      "id": "2"
    },
    {
      "region": "Sousse",
      "lat": "35.83",
      "lng": "10.625",
      "population": "787920",
      "confirmed": "23638",
      "sick": "70913",
      "recovered": "18910",
      "id": "3"
    },
    {
      "region": "Gabès",
      "lat": "33.9004",
      "lng": "10.1",
      "population": "674971",
      "confirmed": "20249",
      "sick": "60747",
      "recovered": "16199",
      "id": "4"
    },
    {
      "region": "Kairouan",
      "lat": "35.6804",
      "lng": "10.1",
      "population": "631842",
      "confirmed": "18955",
      "sick": "56866",
      "recovered": "15164",
      "id": "5"
    },
    {
      "region": "Bizerte",
      "lat": "37.2904",
      "lng": "9.855",
      "population": "576088",
      "confirmed": "17283",
      "sick": "51848",
      "recovered": "13826",
      "id": "6"
    },
    {
      "region": "Gafsa",
      "lat": "34.4204",
      "lng": "8.78",
      "population": "570599",
      "confirmed": "17118",
      "sick": "51354",
      "recovered": "13694",
      "id": "7"
    },
    {
      "region": "Nabeul",
      "lat": "36.4603",
      "lng": "10.73",
      "population": "568219",
      "confirmed": "17047",
      "sick": "51140",
      "recovered": "13637",
      "id": "8"
    },
    {
      "region": "Ariana",
      "lat": "36.8667",
      "lng": "10.2",
      "population": "548828",
      "confirmed": "16465",
      "sick": "49395",
      "recovered": "13172",
      "id": "9"
    },
    {
      "region": "Kasserine",
      "lat": "35.1804",
      "lng": "8.83",
      "population": "479520",
      "confirmed": "14386",
      "sick": "43157",
      "recovered": "11508",
      "id": "10"
    },
    {
      "region": "Monastir",
      "lat": "35.7307",
      "lng": "10.7673",
      "population": "439243",
      "confirmed": "13177",
      "sick": "39532",
      "recovered": "10542",
      "id": "11"
    },
    {
      "region": "Tataouine",
      "lat": "33",
      "lng": "10.4667",
      "population": "429912",
      "confirmed": "12897",
      "sick": "38692",
      "recovered": "10318",
      "id": "12"
    },
    {
      "region": "Medenine",
      "lat": "33.4",
      "lng": "10.4167",
      "population": "410812",
      "confirmed": "12324",
      "sick": "36973",
      "recovered": "9859",
      "id": "13"
    },
    {
      "region": "Béja",
      "lat": "36.7304",
      "lng": "9.19",
      "population": "401477",
      "confirmed": "12044",
      "sick": "36133",
      "recovered": "9635",
      "id": "14"
    },
    {
      "region": "Jendouba",
      "lat": "36.5",
      "lng": "8.75",
      "population": "379518",
      "confirmed": "11386",
      "sick": "34157",
      "recovered": "9108",
      "id": "15"
    },
    {
      "region": "El Kef",
      "lat": "36.1826",
      "lng": "8.7148",
      "population": "374300",
      "confirmed": "11229",
      "sick": "33687",
      "recovered": "8983",
      "id": "16"
    },
    {
      "region": "Mahdia",
      "lat": "35.4839",
      "lng": "11.0409",
      "population": "337331",
      "confirmed": "10120",
      "sick": "30360",
      "recovered": "8096",
      "id": "17"
    },
    {
      "region": "Sidi Bouzid",
      "lat": "35.0167",
      "lng": "9.5",
      "population": "303032",
      "confirmed": "9091",
      "sick": "27273",
      "recovered": "7273",
      "id": "18"
    },
    {
      "region": "Tozeur",
      "lat": "33.9304",
      "lng": "8.13",
      "population": "243156",
      "confirmed": "7295",
      "sick": "21884",
      "recovered": "5836",
      "id": "19"
    },
    {
      "region": "Siliana",
      "lat": "36.0833",
      "lng": "9.3833",
      "population": "223087",
      "confirmed": "6693",
      "sick": "20078",
      "recovered": "5354",
      "id": "20"
    },
    {
      "region": "Kebili",
      "lat": "33.69",
      "lng": "8.971",
      "population": "176945",
      "confirmed": "5308",
      "sick": "15925",
      "recovered": "4247",
      "id": "21"
    },
    {
      "region": "Zaghouan",
      "lat": "36.4",
      "lng": "10.147",
      "population": "156961",
      "confirmed": "4709",
      "sick": "14126",
      "recovered": "3767",
      "id": "22"
    },
    {
      "region": "Ben Arous",
      "lat": "36.7545",
      "lng": "10.2217",
      "population": "149453",
      "confirmed": "4484",
      "sick": "13451",
      "recovered": "3587",
      "id": "23"
    },
    {
      "region": "Manouba",
      "lat": "36.8101",
      "lng": "10.0956",
      "population": "107912",
      "confirmed": "3237",
      "sick": "9712",
      "recovered": "2590",
      "id": "24"
    }
  ];