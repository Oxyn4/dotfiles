local load_status, duckie = pcall(require, "duck")

if not load_status then
	return
end

for duckies=1,1,-1
do 
    duckie.hatch("🦆", 10)
end

