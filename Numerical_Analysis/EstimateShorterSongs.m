function songShorterLength = EstimateShorterSongs ( thresholdLength )

 songLengthMean = 170.3; % (s)
 songLengthStdDev = 14.23; % (s)
 songsPlayedOnRadio = 25.7; % thousands

 rng('default');
 
 songLengthSample = thresholdLength/1000; 
 
 percentageShorter =(1000-thresholdLength)/1000
 songShorterLength = songsPlayedOnRadio - thresholdLength                                      
 
end

