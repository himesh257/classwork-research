function starsInfo = Untitled3(~)
starsInfo = struct;
star_name = ["Mu Cephei","BC Cygni","Altair"];
star_mass = [(3.819*10^31),(3.779*10^31),(3.56*10^30)];
star_dist = [2838,4012,16.73];
star_magnitude = [4.08,9.97,0.77];

for i=1

  starsInfo(i).name = string (star_name(i));
  starsInfo(i).mass = string (max(star_mass));
  starsInfo(i).dist = string (max(star_dist));
  starsInfo(i).magnitude = string (max(star_magnitude));

end



end