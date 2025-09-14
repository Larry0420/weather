const String kRoutesJson = r'''
{
  "light_rail_system": {
    "districts": [
      {
        "name": "Tuen Mun",
        "routes": [
          {
            "route_number": "505",
            "description": "Sam Shing↔Siu Hong",
            "stations": [
              {"name_en": "Kin On", "name_zh": "建安"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Kei Lun", "name_zh": "麒麟"},
              {"name_en": "Ching Chung", "name_zh": "青松"},
              {"name_en": "Kin Sang", "name_zh": "建生"},
              {"name_en": "Tin King", "name_zh": "田景"},
              {"name_en": "Leung King", "name_zh": "良景"},
              {"name_en": "San Wai", "name_zh": "新圍"},
              {"name_en": "Shek Pai", "name_zh": "石排"},
              {"name_en": "Shan King (North)", "name_zh": "山景 (北)"},
              {"name_en": "Shan King (South)", "name_zh": "山景 (南)"},
              {"name_en": "Ming Kum", "name_zh": "鳴琴"},
              {"name_en": "Siu Lun", "name_zh": "兆麟"},
              {"name_en": "On Ting", "name_zh": "安定"},
              {"name_en": "Town Centre", "name_zh": "市中心"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"},
              {"name_en": "Sam Shing", "name_zh": "三聖"}
            ]
          },
          {
            "route_number": "507",
            "description": "Tuen Mun Ferry Pier↔Tin King",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Ho Tin", "name_zh": "河田"},
              {"name_en": "Choy Yee Bridge", "name_zh": "蔡意橋"},
              {"name_en": "Tin King", "name_zh": "田景"},
              {"name_en": "Leung King", "name_zh": "良景"},
              {"name_en": "San Wai", "name_zh": "新圍"},
              {"name_en": "Tai Hing (North)", "name_zh": "大興 (北)"},
              {"name_en": "Tai Hing (South)", "name_zh": "大興 (南)"},
              {"name_en": "Ngan Wai", "name_zh": "銀圍"},
              {"name_en": "Siu Hei", "name_zh": "兆禧"},
              {"name_en": "Tuen Mun Swimming Pool", "name_zh": "屯門泳池"},
              {"name_en": "Goodview Garden", "name_zh": "豐景園"},
              {"name_en": "Siu Lun", "name_zh": "兆麟"},
              {"name_en": "On Ting", "name_zh": "安定"},
              {"name_en": "Town Centre", "name_zh": "市中心"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"}
            ]
          },
          {
            "route_number": "614P",
            "description": "Tuen Mun Ferry Pier↔Siu Hong",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Siu Hei", "name_zh": "兆禧"},
              {"name_en": "Tuen Mun Swimming Pool", "name_zh": "屯門泳池"},
              {"name_en": "Goodview Garden", "name_zh": "豐景園"},
              {"name_en": "On Ting", "name_zh": "安定"},
              {"name_en": "Town Centre", "name_zh": "市中心"},
              {"name_en": "Pui To", "name_zh": "杯渡"},
              {"name_en": "Hoh Fuk Tong", "name_zh": "何福堂"},
              {"name_en": "San Hui", "name_zh": "新墟"},
              {"name_en": "Prime View", "name_zh": "景峰"},
              {"name_en": "Fung Tei", "name_zh": "鳳地"}
            ]
          },
          {
            "route_number": "615P",
            "description": "Tuen Mun Ferry Pier↔Siu Hong",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Melody Garden", "name_zh": "美樂"},
              {"name_en": "Butterfly", "name_zh": "蝴蝶"},
              {"name_en": "Light Rail Depot", "name_zh": "輕鐵車廠"},
              {"name_en": "Lung Mun", "name_zh": "龍門"},
              {"name_en": "Tsing Shan Tsuen", "name_zh": "青山村"},
              {"name_en": "Tsing Wun", "name_zh": "青雲"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Kei Lun", "name_zh": "麒麟"},
              {"name_en": "Ching Chung", "name_zh": "青松"},
              {"name_en": "Kin Sang", "name_zh": "建生"},
              {"name_en": "Tin King", "name_zh": "田景"},
              {"name_en": "Leung King", "name_zh": "良景"},
              {"name_en": "San Wai", "name_zh": "新圍"},
              {"name_en": "Shek Pai", "name_zh": "石排"},
              {"name_en": "Ming Kum", "name_zh": "鳴琴"}
            ]
          }
        ]
      },
      {
        "name": "Tin Shui Wai",
        "routes": [
          {
            "route_number": "705",
            "description": "Tin Shui Wai Loop (Anti-clockwise)",
            "stations": [
              {"name_en": "Tin Shui Wai", "name_zh": "天水圍"},
              {"name_en": "Tin Tsz", "name_zh": "天慈"},
              {"name_en": "Tin Yiu", "name_zh": "天耀"},
              {"name_en": "Locwood", "name_zh": "樂湖"},
              {"name_en": "Tin Wu", "name_zh": "天湖"},
              {"name_en": "Ginza", "name_zh": "銀座"},
              {"name_en": "Tin Shui", "name_zh": "天瑞"},
              {"name_en": "Chung Fu", "name_zh": "頌富"},
              {"name_en": "Tin Fu", "name_zh": "天富"},
              {"name_en": "Tin Wing", "name_zh": "天榮"},
              {"name_en": "Tin Yuet", "name_zh": "天悅"},
              {"name_en": "Tin Sau", "name_zh": "天秀"},
              {"name_en": "Wetland Park", "name_zh": "濕地公園"},
              {"name_en": "Tin Heng", "name_zh": "天恒"},
              {"name_en": "Tin Yat", "name_zh": "天逸"}
            ]
          },
          {
            "route_number": "706",
            "description": "Tin Shui Wai Loop (Clockwise)",
            "stations": [
              {"name_en": "Tin Shui Wai", "name_zh": "天水圍"},
              {"name_en": "Tin Tsz", "name_zh": "天慈"},
              {"name_en": "Tin Yiu", "name_zh": "天耀"},
              {"name_en": "Locwood", "name_zh": "樂湖"},
              {"name_en": "Tin Wu", "name_zh": "天湖"},
              {"name_en": "Ginza", "name_zh": "銀座"},
              {"name_en": "Tin Shui", "name_zh": "天瑞"},
              {"name_en": "Chung Fu", "name_zh": "頌富"},
              {"name_en": "Tin Fu", "name_zh": "天富"},
              {"name_en": "Tin Wing", "name_zh": "天榮"},
              {"name_en": "Tin Yuet", "name_zh": "天悅"},
              {"name_en": "Tin Sau", "name_zh": "天秀"},
              {"name_en": "Wetland Park", "name_zh": "濕地公園"},
              {"name_en": "Tin Heng", "name_zh": "天恒"},
              {"name_en": "Tin Yat", "name_zh": "天逸"}
            ]
          },
          {
            "route_number": "751P",
            "description": "Tin Yat↔Tin Shui Wai",
            "stations": [
              {"name_en": "Tin Shui Wai", "name_zh": "天水圍"},
              {"name_en": "Tin Tsz", "name_zh": "天慈"},
              {"name_en": "Tin Wu", "name_zh": "天湖"},
              {"name_en": "Ginza", "name_zh": "銀座"},
              {"name_en": "Chung Fu", "name_zh": "頌富"},
              {"name_en": "Tin Fu", "name_zh": "天富"},
              {"name_en": "Chestwood", "name_zh": "翠湖"},
              {"name_en": "Tin Wing", "name_zh": "天榮"},
              {"name_en": "Tin Yat", "name_zh": "天逸"}
            ]
          }
        ]
      },
      {
        "name": "Inter-District",
        "routes": [
          {
            "route_number": "610",
            "description": "Tuen Mun Ferry Pier↔Yuen Long",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Melody Garden", "name_zh": "美樂"},
              {"name_en": "Butterfly", "name_zh": "蝴蝶"},
              {"name_en": "Light Rail Depot", "name_zh": "輕鐵車廠"},
              {"name_en": "Lung Mun", "name_zh": "龍門"},
              {"name_en": "Tsing Shan Tsuen", "name_zh": "青山村"},
              {"name_en": "Tsing Wun", "name_zh": "青雲"},
              {"name_en": "Ho Tin", "name_zh": "河田"},
              {"name_en": "Choy Yee Bridge", "name_zh": "蔡意橋"},
              {"name_en": "Affluence", "name_zh": "澤豐"},
              {"name_en": "Tuen Mun Hospital", "name_zh": "屯門醫院"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Ming Kum", "name_zh": "鳴琴"},
              {"name_en": "Tai Hing (North)", "name_zh": "大興 (北)"},
              {"name_en": "Tai Hing (South)", "name_zh": "大興 (南)"},
              {"name_en": "Ngan Wai", "name_zh": "銀圍"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"},
              {"name_en": "Lam Tei", "name_zh": "藍地"},
              {"name_en": "Nai Wai", "name_zh": "泥圍"},
              {"name_en": "Chung Uk Tsuen", "name_zh": "鍾屋村"},
              {"name_en": "Hung Shui Kiu", "name_zh": "洪水橋"},
              {"name_en": "Tong Fong Tsuen", "name_zh": "塘坊村"},
              {"name_en": "Ping Shan", "name_zh": "屏山"},
              {"name_en": "Shui Pin Wai", "name_zh": "水邊圍"},
              {"name_en": "Fung Nin Road", "name_zh": "豐年路"},
              {"name_en": "Hong Lok Road", "name_zh": "康樂路"},
              {"name_en": "Tai Tong Road", "name_zh": "大棠路"},
              {"name_en": "Yuen Long", "name_zh": "元朗"}
            ]
          },
          {
            "route_number": "614",
            "description": "Tuen Mun Ferry Pier↔Yuen Long",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Melody Garden", "name_zh": "美樂"},
              {"name_en": "Butterfly", "name_zh": "蝴蝶"},
              {"name_en": "Light Rail Depot", "name_zh": "輕鐵車廠"},
              {"name_en": "Lung Mun", "name_zh": "龍門"},
              {"name_en": "Tsing Shan Tsuen", "name_zh": "青山村"},
              {"name_en": "Tsing Wun", "name_zh": "青雲"},
              {"name_en": "Ho Tin", "name_zh": "河田"},
              {"name_en": "Choy Yee Bridge", "name_zh": "蔡意橋"},
              {"name_en": "Affluence", "name_zh": "澤豐"},
              {"name_en": "Tuen Mun Hospital", "name_zh": "屯門醫院"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Ming Kum", "name_zh": "鳴琴"},
              {"name_en": "Tai Hing (North)", "name_zh": "大興 (北)"},
              {"name_en": "Tai Hing (South)", "name_zh": "大興 (南)"},
              {"name_en": "Ngan Wai", "name_zh": "銀圍"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"},
              {"name_en": "Lam Tei", "name_zh": "藍地"},
              {"name_en": "Nai Wai", "name_zh": "泥圍"},
              {"name_en": "Chung Uk Tsuen", "name_zh": "鍾屋村"},
              {"name_en": "Hung Shui Kiu", "name_zh": "洪水橋"},
              {"name_en": "Tong Fong Tsuen", "name_zh": "塘坊村"},
              {"name_en": "Ping Shan", "name_zh": "屏山"},
              {"name_en": "Shui Pin Wai", "name_zh": "水邊圍"},
              {"name_en": "Fung Nin Road", "name_zh": "豐年路"},
              {"name_en": "Hong Lok Road", "name_zh": "康樂路"},
              {"name_en": "Tai Tong Road", "name_zh": "大棠路"},
              {"name_en": "Yuen Long", "name_zh": "元朗"}
            ]
          },
          {
            "route_number": "615",
            "description": "Tuen Mun Ferry Pier↔Yuen Long",
            "stations": [
              {"name_en": "Tuen Mun Ferry Pier", "name_zh": "屯門碼頭"},
              {"name_en": "Melody Garden", "name_zh": "美樂"},
              {"name_en": "Butterfly", "name_zh": "蝴蝶"},
              {"name_en": "Light Rail Depot", "name_zh": "輕鐵車廠"},
              {"name_en": "Lung Mun", "name_zh": "龍門"},
              {"name_en": "Tsing Shan Tsuen", "name_zh": "青山村"},
              {"name_en": "Tsing Wun", "name_zh": "青雲"},
              {"name_en": "Ho Tin", "name_zh": "河田"},
              {"name_en": "Choy Yee Bridge", "name_zh": "蔡意橋"},
              {"name_en": "Affluence", "name_zh": "澤豐"},
              {"name_en": "Tuen Mun Hospital", "name_zh": "屯門醫院"},
              {"name_en": "Siu Hong", "name_zh": "兆康"},
              {"name_en": "Ming Kum", "name_zh": "鳴琴"},
              {"name_en": "Tai Hing (North)", "name_zh": "大興 (北)"},
              {"name_en": "Tai Hing (South)", "name_zh": "大興 (南)"},
              {"name_en": "Ngan Wai", "name_zh": "銀圍"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"},
              {"name_en": "Lam Tei", "name_zh": "藍地"},
              {"name_en": "Nai Wai", "name_zh": "泥圍"},
              {"name_en": "Chung Uk Tsuen", "name_zh": "鍾屋村"},
              {"name_en": "Hung Shui Kiu", "name_zh": "洪水橋"},
              {"name_en": "Tong Fong Tsuen", "name_zh": "塘坊村"},
              {"name_en": "Ping Shan", "name_zh": "屏山"},
              {"name_en": "Shui Pin Wai", "name_zh": "水邊圍"},
              {"name_en": "Fung Nin Road", "name_zh": "豐年路"},
              {"name_en": "Hong Lok Road", "name_zh": "康樂路"},
              {"name_en": "Tai Tong Road", "name_zh": "大棠路"},
              {"name_en": "Yuen Long", "name_zh": "元朗"}
            ]
          },
          {
            "route_number": "761P",
            "description": "Tin Yat↔Yuen Long",
            "stations": [
              {"name_en": "Tin Yat", "name_zh": "天逸"},
              {"name_en": "Tin Heng", "name_zh": "天恒"},
              {"name_en": "Wetland Park", "name_zh": "濕地公園"},
              {"name_en": "Tin Sau", "name_zh": "天秀"},
              {"name_en": "Tin Yuet", "name_zh": "天悅"},
              {"name_en": "Tin Wing", "name_zh": "天榮"},
              {"name_en": "Tin Fu", "name_zh": "天富"},
              {"name_en": "Chung Fu", "name_zh": "頌富"},
              {"name_en": "Tin Shui", "name_zh": "天瑞"},
              {"name_en": "Ginza", "name_zh": "銀座"},
              {"name_en": "Tin Wu", "name_zh": "天湖"},
              {"name_en": "Locwood", "name_zh": "樂湖"},
              {"name_en": "Tin Yiu", "name_zh": "天耀"},
              {"name_en": "Tin Tsz", "name_zh": "天慈"},
              {"name_en": "Tin Shui Wai", "name_zh": "天水圍"},
              {"name_en": "Shui Pin Wai", "name_zh": "水邊圍"},
              {"name_en": "Fung Nin Road", "name_zh": "豐年路"},
              {"name_en": "Hong Lok Road", "name_zh": "康樂路"},
              {"name_en": "Tai Tong Road", "name_zh": "大棠路"},
              {"name_en": "Yuen Long", "name_zh": "元朗"}
            ]
          },
          {
            "route_number": "751",
            "description": "Tin Yat↔Yau Oi",
            "stations": [
              {"name_en": "Tin Yat", "name_zh": "天逸"},
              {"name_en": "Tin Heng", "name_zh": "天恒"},
              {"name_en": "Wetland Park", "name_zh": "濕地公園"},
              {"name_en": "Tin Sau", "name_zh": "天秀"},
              {"name_en": "Tin Yuet", "name_zh": "天悅"},
              {"name_en": "Tin Wing", "name_zh": "天榮"},
              {"name_en": "Tin Fu", "name_zh": "天富"},
              {"name_en": "Chung Fu", "name_zh": "頌富"},
              {"name_en": "Tin Shui", "name_zh": "天瑞"},
              {"name_en": "Ginza", "name_zh": "銀座"},
              {"name_en": "Tin Wu", "name_zh": "天湖"},
              {"name_en": "Locwood", "name_zh": "樂湖"},
              {"name_en": "Tin Yiu", "name_zh": "天耀"},
              {"name_en": "Tin Tsz", "name_zh": "天慈"},
              {"name_en": "Tin Shui Wai", "name_zh": "天水圍"},
              {"name_en": "Shui Pin Wai", "name_zh": "水邊圍"},
              {"name_en": "Fung Nin Road", "name_zh": "豐年路"},
              {"name_en": "Hong Lok Road", "name_zh": "康樂路"},
              {"name_en": "Tai Tong Road", "name_zh": "大棠路"},
              {"name_en": "Yuen Long", "name_zh": "元朗"},
              {"name_en": "Tong Fong Tsuen", "name_zh": "塘坊村"},
              {"name_en": "Hung Shui Kiu", "name_zh": "洪水橋"},
              {"name_en": "Chung Uk Tsuen", "name_zh": "鍾屋村"},
              {"name_en": "Nai Wai", "name_zh": "泥圍"},
              {"name_en": "Lam Tei", "name_zh": "藍地"},
              {"name_en": "Fung Tei", "name_zh": "鳳地"},
              {"name_en": "Prime View", "name_zh": "景峰"},
              {"name_en": "San Hui", "name_zh": "新墟"},
              {"name_en": "Hoh Fuk Tong", "name_zh": "何福堂"},
              {"name_en": "Pui To", "name_zh": "杯渡"},
              {"name_en": "Tuen Mun", "name_zh": "屯門"},
              {"name_en": "Town Centre", "name_zh": "市中心"},
              {"name_en": "On Ting", "name_zh": "安定"},
              {"name_en": "Yau Oi", "name_zh": "友愛"}
            ]
          }
        ]
      }
    ]
  }
}
''';