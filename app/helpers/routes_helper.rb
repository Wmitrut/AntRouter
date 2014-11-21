module RoutesHelper

    def distance(a, b)
      if (a.nil? or b.nil?)
        puts "ERRO: Sem pontos para calcular dist"
        return 1000000
      end
      ponto_a = a.address
      ponto_b = b.address
      #x = ponto_a.latitude - ponto_b.latitude
      #y = ponto_a.longitude - ponto_b.longitude
      #return Math.sqrt((x*x) + (y*y))
      lat1 = ponto_a.latitude
      radianLat1 = lat1 * (Math::PI / 180.0)
      lng1 = ponto_a.longitude
      radianLng1 = lng1 * (Math::PI / 180.0)
      lat2 = ponto_b.latitude
      radianLat2 = lat2 * (Math::PI / 180.0)
      lng2 = ponto_b.longitude
      radianLng2 = lng2 * (Math::PI / 180.0)
      earth_radius = 6371.0 #kilometers
      diffLat = (radianLat1 - radianLat2)
      diffLng = (radianLng1 - radianLng2)
      sinLat = Math.sin(diffLat / 2.0)
      sinLng = Math.sin(diffLng / 2.0)
      a = (sinLat ** 2.0) + Math.cos(radianLat1) * Math.cos(radianLat2) * (sinLng ** 2.0)
      distance = earth_radius * 2.0 * Math.asin([1, Math.sqrt(a)].min)
      return distance
    end

end
