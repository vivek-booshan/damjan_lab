using DelimitedFiles
using StatsBase
using Plots

z_traj_POT = readdlm("ztraj_resname_POT.dat")
z_traj_CLA = readdlm("ztraj_resname_CLA.dat")

########## hist ###########
#Fields
#################################
# edges :: Tuple{Vector{Float64}}
# weights :: Vector{Int64}
# closed :: Symbol
# isdensity :: Bool

bin_width = 1  #Ångstroms
bins = floor(minimum(z_traj_POT)):bin_width:ceil(maximum(z_traj))
hist_POT = fit(Histogram, z_traj_POT[:], bins)
hist_POT.weights = hist_POT.weights / bin_width

###### If you want separate bins for each ion #########
# bin_width = 1   
# bins = floor(minimum(z_traj_CLA)):bin_width:ceil(maximum(z_traj_CLA))
hist_CLA = fit(Histogram, z_traj_CLA[:], bins)
hist_CLA.weights = hist_CLA.weights / bin_width

# 1-indexing; needed explicit slicing
z_centers = (bins[2:end] + bins[1:end-1]) / 2 # find center of bins (n -> n-1) length

ion_plot = plot(
    z_centers, 
    [hist_POT.weights, hist_CLA.weights],
    title = "Ion Densities",
    label=["resname POT" "resname CLA"]
    )
xlabel!("Z (Ångstroms)")
ylabel!("Ion Density (Ions / Ångstroms)")

#check for file
if !(isfile("ion_densities.png")) 
    savefig(ion_plot, "ion_densities")
end
