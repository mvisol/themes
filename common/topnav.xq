xquery version "1.0";

module namespace this="http://vyasaka.com/vya-platform/themes/navController";

declare function this:listTopNav($items as node())
{   
    let $x := util:log-system-out("%%%%%%%%%%%%%%%%%%%%%%%%%%44")
    return
     if (name($items) = 'solutions') then  
        this:listSolutions($items) 
     else 
        this:listSolutions($items)
};

declare function this:listSolutions($solutions as element(solutions))
{   
    let $x := util:log-system-out("%%%%%%%%%%%%%%%%%%%%%%%%%%55")
        let $x := util:log-system-out(concat("solutions:",$solutions))
        return
        <div id="utility">
            <ul class="flatlinks">
    		{	
    			for $solution in $solutions//*:solutionInfo
				let $href := $solution//*:generalInfo/*:controller
    			let $li := <li><a href="{$href}">{$solution/*:generalInfo/*:name/text()}</a></li>
                return $li
    		}
    		</ul>
    	</div>
};

declare function this:listModules($modules as element(modules)*,$solutions as element(solutions)*)

{       <div id="utility">
    		<ul class="flatlinks topnav">
            {
                let $first-four :=
                for $solution at $row in $solutions//*:solutionInfo
                  let $four := 
                    if ($row <= 5) then ( 
                        let $href := $solution//*:generalInfo/*:controller
                		let $li := <li><a href="{$href}">{$solution//*:generalInfo/*:name/text()}</a></li>
                        return $li
                    )
                    else ()
                return $four 

            return $first-four
            }
            {
                let $more := 
                if (count($solutions//*:solutionInfo)>5) then
                    <li><a href="#">More <b class="caret"></b></a>
                    <ul class="subnav">
                    {    
                        let $rest-all :=
                        for $solution at $row in $solutions//*:solutionInfo
                      let $rest := 
                        if ($row > 5) then ( 
                            let $href := $solution//*:generalInfo/*:controller
                        	let $li := <li><a href="{$href}">{$solution//*:generalInfo/*:name/text()}</a></li>
                            return $li
                        )
                        else ()
                    return $rest 
    
                    return $rest-all
            		}
                    </ul>
                    </li>
                else ()
                return $more
            }
            <!--
            <li><a href="../appstore/index.html">App Central</a></li>
            <li><a href="../portal/index.html">Portal</a></li>
            <li><a href="../devstudio/index.html">Development</a></li>-->
    		</ul>
    	</div>
};
