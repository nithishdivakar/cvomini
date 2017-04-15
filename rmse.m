function [ err ] = rmse( y, haty )
%RMSE Summary of this function goes here
%   Detailed explanation goes here

err = sqrt(mean((y - haty).^2));
end

