
{if $warnings_cnt}
<b><font style='color:red' >Errors:</font></b>
{foreach from=$warnings item=val key=key}
	<br>
	<font style='color:red' >{$val}</font>
{/foreach}
{/if}

    <div style='float:left; width:600px;'>
		<br>
		<b>{t}Optional settings{/t}</b>
	</div>


	
    <div class='step4_container'>
        <div class='step4_name'>
            {t}Enable Copy & Paste{/t}
        </div>
        <div class='step4_value'>
	
            <select name="enableCopyPaste" size="1" title="">
            	{html_options options=$bool selected=$optional.enableCopyPaste}
            </select>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Force globals{/t}
        </div>
        <div class='step4_value'>
	
            <select name="forceglobals" size="1" title="">
            	{html_options options=$bool selected=$optional.forceglobals}
            </select>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Force SSL{/t}
        </div>
        <div class='step4_value'>
	
            <select name="forcessl" size="1" title="">
            	{html_options options=$bool selected=$optional.forcessl}
            </select>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Warn SSL{/t}
        </div>
        <div class='step4_value'>
	
            <select name="warnssl" size="1" title="">
            	{html_options options=$bool selected=$optional.warnssl}
            </select>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}PPd path{/t}
        </div>
        <div class='step4_value'>
            {if $optional.ppd_path_active == FALSE}
                <input type='checkbox' value='1' name='ppd_path_active'
                    onClick='changeState("ppd_path");'>
                <input style='width:90%' id='ppd_path' name='ppd_path' type='text' value='{$optional.ppd_path}' disabled>
            {else}
                <input type='checkbox' value='1' name='ppd_path_active' checked>
                <input style='width:90%' id='ppd_path' name='ppd_path' type='text' value='{$optional.ppd_path}'  >
            {/if}
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Kde applications menu{/t}
        </div>
        <div class='step4_value'>
            {if $optional.kde_applications_menu_active == FALSE}
                <input type='checkbox' value='1' name='kde_applications_menu_active'
                    onClick='changeState("kde_applications_menu");'>
                <input style='width:90%' id='kde_applications_menu' name='kde_applications_menu' 
					type='text' value='{$optional.kde_applications_menu}' disabled>
            {else}
                <input type='checkbox' value='1' name='kde_applications_menu_active' checked>
                <input style='width:90%' id='kde_applications_menu' name='kde_applications_menu' 
					type='text' value='{$optional.kde_applications_menu}'  >
            {/if}
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Smarty compile directory{/t}
        </div>
        <div class='step4_value'>
			<input style='width:90%' id='compile' name='compile' 
				type='text' value='{$optional.compile}'>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}SMB hash{/t}
        </div>
        <div class='step4_value'>
			<input style='width:90%' id='smbhash' name='smbhash' 
				type='text' value='{$optional.smbhash}'>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Session lifetime{/t}
        </div>
        <div class='step4_value'>
			<input style='width:90%' id='session_lifetime' name='session_lifetime' 
				type='text' value='{$optional.session_lifetime}'>
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Maximal ldap query time{/t}
        </div>
        <div class='step4_value'>
            {if $optional.max_ldap_query_time_active == FALSE}
                <input type='checkbox' value='1' name='max_ldap_query_time_active'
                    onClick='changeState("max_ldap_query_time");'>
                <input style='width:90%' id='max_ldap_query_time' name='max_ldap_query_time' 
					type='text' value='{$optional.max_ldap_query_time}' disabled>
            {else}
                <input type='checkbox' value='1' name='max_ldap_query_time_active' checked>
                <input style='width:90%' id='max_ldap_query_time' name='max_ldap_query_time' 
					type='text' value='{$optional.max_ldap_query_time}'  >
            {/if}
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>

    <div class='step4_container'>
        <div class='step4_name'>
            {t}Debuglevel{/t}
        </div>
        <div class='step4_value'>
			<select name='debuglevel'>
				{if $optional.debuglevel == 0}
					<option value='0' selected>0 {t}Disabled{/t}</option>
					<option value='1'>1 {t}Enabled{/t}</option>
				{else}
					<option value='0'>0 {t}Disabled{/t}</option>
					<option value='1' selected>1 {t}Enabled{/t}</option>
				{/if}
			</select>		
        </div>
        <div class='step4_status'>
            {t}Infos in FAQ{/t}&nbsp;
            <img class='center' src='images/info_small.png' title='{t}Please read the FAQ for more informations{/t}'>
        </div>
    </div>


<input type='hidden' value='1' name='step6a_posted'>
