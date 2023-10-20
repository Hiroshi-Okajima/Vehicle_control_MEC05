function kd = kappa_fun(s1,s2)
	 s = s2 + s1;%Œo˜H’·‚³
	 kd = zeros(2,1);%kd1‚Í‹È—¦kd2‚Í‚»‚Ì”÷•ª
     if s > 150
kd(1) = 0.04;
kd(2) = 0;
elseif s>12
kd(1) = 0.037*(1-cos(s*0.15-1.8));
kd(2) = 0.037*0.15*sin(s*0.15-1.8);
%kd(1) = 0;
%kd(2) = 0;
else
kd(1)=0;
kd(2)=0;
end
