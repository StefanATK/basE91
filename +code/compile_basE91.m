%% compile_basE91
function compile_basE91()
% compile the basE91 encode and decode functions as mex file
	cfg = coder.config('mex');
	cfg.GenerateReport = true;
	cfg.ReportPotentialDifferences = false;
	
	td = coder.newtype('int8', [1 256], [0 0]);
	td1 = coder.newtype('char', [1 Inf], [0 1]);
	td2 = coder.newtype('char', [Inf 1], [1 0]);
	te = coder.newtype('char', [1 91], [0 0]);
	te1 = coder.newtype('uint8', [1 Inf], [0 1]);
	te2 = coder.newtype('uint8', [Inf 1], [1 0]);
	codegen("-config",cfg,".\+code\bE91decode.m","-args",{td1,td}, "-args", {td2,td}, "-nargout", 1, ...
		".\+code\bE91encode.m","-args",{te1,te}, "-args", {te2,te}, "-nargout", 1,...
		"-report","-o", "bE91")
end
