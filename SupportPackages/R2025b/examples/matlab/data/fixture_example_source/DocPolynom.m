classdef DocPolynom < matlab.mixin.Scalar

    properties
        coef
    end

    methods
        function obj = DocPolynom(c)
            if nargin > 0
                if isa(c,'DocPolynom')
                    obj.coef = c.coef;
                else
                    obj.coef = c(:).';
                end
            end
        end

        function obj = set.coef(obj,val)
            if ~isa(val,'double')
                error('Coefficients must be doubles.')
            end
            ind = find(val(:).'~=0);
            if isempty(ind)
                obj.coef = val;
            else
                obj.coef = val(ind(1):end);
            end
        end

        function c = double(obj)
            c = obj.coef;
        end

        function str = char(obj)
            if all(obj.coef == 0)
                s = '0';
                str = s;
                return
            else
                d = length(obj.coef) - 1;
                s = cell(1,d);
                ind = 1;
                for a = obj.coef
                    if a ~= 0
                        if ind ~= 1
                            if a > 0
                                s(ind) = {' + '};
                                ind = ind + 1;
                            else
                                s(ind) = {' - '};
                                a = -a;
                                ind = ind + 1;
                            end
                        end
                        if a ~= 1 || d == 0
                            if a == -1
                                s(ind) = {'-'};
                                ind = ind + 1;
                            else
                                s(ind) = {num2str(a)};
                                ind = ind + 1;
                                if d > 0
                                    s(ind) = {'*'};
                                    ind = ind + 1;
                                end
                            end
                        end
                        if d >= 2
                            s(ind) = {['x^' int2str(d)]};
                            ind = ind + 1;
                        elseif d == 1
                            s(ind) = {'x'};
                            ind = ind + 1;
                        end
                    end
                    d = d - 1;
                end
            end
            str = [s{:}];
        end

        function disp(obj)
            c = char(obj);
            if iscell(c)
                disp(['     ' c{:}])
            else
                disp(c)
            end
        end

        function dispPoly(obj,x)
            p = char(obj);
            y = zeros(length(x));
            disp(['f(x) = ',p])
            for k = 1:length(x)
                y(k) = polyval(obj.coef,x(k));
                disp(['   f(',num2str(x(k)),') = ',num2str(y(k))])
            end
        end

        function r = plus(obj1,obj2)
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            k = length(obj2.coef) - length(obj1.coef);
            zp = zeros(1,k);
            zm = zeros(1,-k);
            r = DocPolynom([zp,obj1.coef] + [zm,obj2.coef]);
        end

        function r = minus(obj1,obj2)
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            k = length(obj2.coef) - length(obj1.coef);
            zp = zeros(1,k);
            zm = zeros(1,-k);
            r = DocPolynom([zp,obj1.coef] - [zm,obj2.coef]);
        end

        function r = mtimes(obj1,obj2)
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            r = DocPolynom(conv(obj1.coef,obj2.coef));
        end
    end

    methods (Access = protected)
        function f = parenReference(obj,indexOp)
            n = cell2mat(indexOp(1).Indices);
            if numel(indexOp) == 1
                f = polyval(obj.coef,n);
            else
                f = polyval(obj.coef,n).(indexOp(2:end));
            end
        end
    end
end