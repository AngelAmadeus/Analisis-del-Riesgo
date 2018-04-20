load BlueChipStockMoments

mret = MarketMean;
mrsk = sqrt(MarketVar);
cret = CashMean;
crsk = sqrt(CashVar);


p = Portfolio('AssetList', AssetList, 'RiskFreeRate', CashMean);
p = setAssetMoments(p, AssetMean, AssetCovar);

p = setInitPort(p, 1/p.NumAssets);
[ersk, eret] = estimatePortMoments(p, p.InitPort);

clf;
portfolioexamples_plot('Asset Risks and Returns', ...
	{'scatter', mrsk, mret, {'Market'}}, ...
	{'scatter', crsk, cret, {'Cash'}}, ...
	{'scatter', ersk, eret, {'Equal'}}, ...
	{'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});

p = setDefaultConstraints(p);

pwgt = estimateFrontier(p, 20);
[prsk, pret] = estimatePortMoments(p, pwgt);

% Plot efficient frontier

clf;
portfolioexamples_plot('Efficient Frontier', ...
	{'line', prsk, pret}, ...
	{'scatter', [mrsk, crsk, ersk], [mret, cret, eret], {'Market', 'Cash', 'Equal'}}, ...
	{'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});

[rsk, ret] = estimatePortMoments(p, estimateFrontierLimits(p));

display(rsk);

display(ret);