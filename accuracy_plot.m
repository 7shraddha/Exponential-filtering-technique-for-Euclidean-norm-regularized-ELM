x= [50	100	150	200	250	300	350	400	450	500		
];
y1 = [76.406	76.992	76.953	76.836	76.609	76.732	76.496	76.416	76.363	76.102		
];
y2= [75.547	76.875	77.109	77.031	76.703	76.914	76.629	76.387	76.345	76.023	
];

figure;

% semilogy(x,y1);
% hold on;
% semilogy(x,y2);

plot(x,y1);
hold on;
plot(x,y2);
legend('Tikhonov Regularization','Fractional Tikhonov regularization');

% y = [82.36	91.179	87.275	78.118	65.347	67.575	90.037	95.333	54.124	80.857	81.943;
% % 81.409	80.247	85.456	76.375	60.139	53.893	91.212	95.889	59.873	82.27	78.044;
% % 79.297	99.565	97.811	80.227	57.97	48.462	91.667	95.333	78.551	75.278	75.402;
% % 84.852	86.619	68.056	76.101	71	77.8	95.145	97.667	40.556	85.606	86.196;
% % 80.088	88.823	91.018	78.021	58.495	50.853	91.43	95.609	67.907	77.834	76.68
% 83.684	93.989	91.392	80.289	66.742	69.812	93.125	96.667	59.516	81.857	83.852 ;
% 88.296	96.768	98	70.566	82.864	74.154	68.373	88.714	86.311	98.125	96.026
% 
% 
% ];
% bar(y,0.2)
% 
% ylabel('Testing accuracy') % label for y axis
% xlabel('Classifiers') % label for x axis
% Labels = {'PNN', 'WPNN', 'BWLPNN'};
% set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
% legend('Australian Credit','Breast Cancer','Ionoshpere','Mammographic Masses','Liver disorder','PIMA Diabetic','Wine','Iris','Retinopathy','Sonar','Spambase')