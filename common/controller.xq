xquery version "1.0";
module namespace this="http://vyasaka.com/vya-platform/themes/themeController";

declare namespace html="http://www.w3.org/1999/xhtml";
declare namespace ev="http://www.w3.org/2001/xml-events" ;
declare namespace xs="http://www.w3.org/2001/XMLSchema" ;
declare namespace xf="http://www.w3.org/2002/xforms" ;
declare namespace xsi="http://www.w3.org/2001/XMLSchema-instance";
  
declare function this:renderOutput(
    $layout,
    $theme as xs:string,
    $params ,
    $dynaInstances,
    $content as item()*
	)
{
    if (empty($layout)) then 
        this:pageOutput($theme,$params,$dynaInstances, $content)
    else 
        if ($layout eq 'sidebarCollapse') then 
            this:sidebarCollapseOutput($theme,$params, $dynaInstances, $content)
        else
            this:sidebarCollapseOutput($theme,$params, $dynaInstances, $content)
};

declare function this:assembleLayout(
    $theme as xs:string,
	$content as item()*
	)
{ 
    let $a := this:loadContentAssembler($theme)    
    let $content := util:eval('content-assembler:assembleLayout($content)')
    return $content
};

declare function this:assembleContents(
    $theme as xs:string,
    $content as item()*
	) as node()*
{
    let $a := this:loadContentAssembler($theme)    
    let $content := util:eval('content-assembler:assembleContents($content)')
    return $content
};

declare function this:assembleTabs(
    $theme as xs:string,
    $fragments as node(),
    $content as item()*
	)
{
    let $a := this:loadTabAssembler($theme)    
    let $content := util:eval('tab-assembler:assemble($fragments, $content)')
    return $content 
};

declare function this:pageOutput(
    $theme as xs:string,
    $params ,
    $page-info ,
    $content as item()*
	)
{
    let $a := this:loadLayout($theme)    
    return util:eval('theme:pageOutput($params,$page-info,$content)')
};

declare function this:sidebarCollapseOutput(
    $theme as xs:string,
    $params ,
    $page-info ,
	$content as item()*
	)
{
    let $a := this:loadLayout($theme)    
    return util:eval('theme:sidebarCollapseOutput($params,$page-info,$content)')
};

declare function this:loadLayout($theme as xs:string)
{
    let $ns := concat('http://vyasaka.com/vya-platform/themes/',$theme)
    let $fn := concat('../',$theme,'/modules/page-layout.xqy')
    
    return util:import-module(
        xs:anyURI($ns), 
        'theme', 
        xs:anyURI($fn)
        )
};

declare function this:loadContentAssembler($theme as xs:string)
{
    let $ns := concat('http://vyasaka.com/vya-platform/themes/',$theme,'/content-assembler')
    let $fn := concat('../',$theme,'/modules/content-assembler.xqy')
    
    return util:import-module(
        xs:anyURI($ns), 
        'content-assembler', 
        xs:anyURI($fn)
        )
};

declare function this:loadTabAssembler($theme as xs:string)
{
    let $ns := concat('http://vyasaka.com/vya-platform/themes/',$theme,'/tab-assembler')
    let $fn := concat('../',$theme,'/modules/tab-assembler.xqy')
    
    return util:import-module(
        xs:anyURI($ns), 
        'tab-assembler', 
        xs:anyURI($fn)
        )
};
