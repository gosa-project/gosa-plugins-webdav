<?php

class webdavAccount extends plugin
{
  /* Definitions */
  var $plHeadline= "WebDAV";
  var $plDescription= "Manage WebDAV user settings";

  /* attribute list for save action */
  var $attributes= array();
  var $objectclasses= array("gosaWebDAVAccount");
  var $ReadOnly = false;
  var $view_logged = FALSE;
  var $uid ="";

  var $multiple_support =TRUE;

  function __construct(&$config, $dn= NULL)
  {
    plugin::__construct ($config, $dn);
    
    /* Setting uid to default */
    if(isset($this->attrs['uid'][0])){
      $this->uid = $this->attrs['uid'][0];
    }
  }

  function execute()
  {
	/* Call parent execute */
//	plugin::execute();

    /* Log view */
    if($this->is_account && !$this->view_logged){
      $this->view_logged = TRUE;
      new log("view","users/".get_class($this),$this->dn);
    }

    /* Show tab dialog headers */
    $display= "";

    /* Show main page */
    $smarty= get_smarty();

    if ($this->is_account){
      $smarty->assign("webdavState", "checked");
    } else {
      $smarty->assign("webdavState", "");
      $smarty->assign("wstate", "disabled");
    }

    if ($this->parent !== NULL){
      $smarty->assign("tabbed", 1);
    }

   /* check if we are allowed to switch the checkbox.
    */
    $smarty->assign('webdavAccountACL', preg_replace("/w/","",$this->getacl("",$this->ReadOnly)));
    if(($this->acl_is_removeable() && $this->is_account) ||
        ($this->acl_is_createable() && !$this->is_account)){
      $smarty->assign('webdavAccountACL', $this->getacl("",$this->ReadOnly));
    }

    $smarty->assign("use_webdav",in_array_strict("webdav",$this->multi_boxes));
    $smarty->assign("multiple_support",$this->multiple_support_active);
    $display.= $smarty->fetch (get_template_path('webdav.tpl', TRUE, dirname(__FILE__)));
    return ($display);
  }

  function remove_from_parent()
  {
    if($this->acl_is_createable() || $this->is_account){
      /* Cancel if there's nothing to do here */
      if (!$this->initially_was_account){
        return;
      }

      plugin::remove_from_parent();
      $ldap= $this->config->get_ldap_link();

      $ldap->cd($this->dn);
      @DEBUG (DEBUG_LDAP, __LINE__, __FUNCTION__, __FILE__,
          $this->attributes, "Save");
      $this->cleanup();
      $ldap->modify ($this->attrs); 

      /* Log last action */
      new log("remove","users/".get_class($this),$this->dn,array_keys($this->attrs),$ldap->get_error());

      if (!$ldap->success()){
        msg_dialog::display(_("LDAP error"), msgPool::ldaperror($ldap->get_error(), $this->dn, LDAP_MOD, __CLASS__));
      }

      /* Optionally execute a command after we're done */
      $this->handle_post_events('remove',array("uid" => $this->uid));
    }
  }


  /* Save data to object */
  function save_object()
  {
    /* Do we need to flip is_account state? */
    if (isset($_POST['connectivityTab'])){
      if (isset($_POST['webdav'])){
        if (!$this->is_account && $_POST['webdav'] == "B"){
          if($this->acl_is_createable()){
            $this->is_account= TRUE;
          }
        }
      } else {
        if($this->acl_is_removeable()){
          $this->is_account= FALSE;
        }
      }
    }

    plugin::save_object();
    if (isset($_POST["WEBDAVStatus"])){
      $this->WEBDAVStatus = "disabled";
    } else {
      $this->WEBDAVStatus = "enabled";
    }
  }


  /* Save to LDAP */
  function save()
  {
      plugin::save();

      /* Write back to ldap */
      $ldap= $this->config->get_ldap_link();
      $ldap->cd($this->dn);
      $this->cleanup();
      $ldap->modify ($this->attrs); 

      /* Log last action */
      if($this->initially_was_account){
          new log("modify","users/".get_class($this),$this->dn,array_keys($this->attrs),$ldap->get_error());
      }else{
          new log("create","users/".get_class($this),$this->dn,array_keys($this->attrs),$ldap->get_error());
      }

      if (!$ldap->success()){
          msg_dialog::display(_("LDAP error"), msgPool::ldaperror($ldap->get_error(), $this->dn, LDAP_MOD, __CLASS__));
      }

      /* Optionally execute a command after we're done */
      if ($this->initially_was_account == $this->is_account){
          if ($this->is_modified){
              $this->handle_post_events("modify",array("uid" => $this->uid));
          }
      } else {
          $this->handle_post_events("add",array("uid" => $this->uid));
      }
  }


  /* Return plugin informations for acl handling
      #FIXME This is only an enable/disable checkbox for this account, there is possibly a better solution available later */
  static function plInfo()
  {
    return (array(  
          "plShortName"     => _("WebDAV"),
          "plDescription"   => _("WebDAV account")."&nbsp;("._("Connectivity add-on").")",
          "plSelfModify"    => TRUE,
          "plDepends"       => array("user"),
          "plRequirements"=> array(
              'ldapSchema' => array('gosaWebDAVAccount' => '>=2.7'),
              'onFailureDisablePlugin' => array(__CLASS__)
              ),
          "plPriority"      => 23,                                 // Position in tabs
          "plSection"     => array("personal" => _("My account")),
          "plCategory"    => array("users"),
          "plOptions"       => array(),

          "plProvidedAcls"  => array()
          ));
  }

  function multiple_save_object()
  {
    if (isset($_POST['connectivityTab'])){
      plugin::multiple_save_object();

      if(isset($_POST['use_webdav'])){
        $this->multi_boxes[] = "webdav";
        if (isset($_POST['webdav'])){
          if (!$this->is_account && $_POST['webdav'] == "B"){
            if($this->acl_is_createable()){
              $this->is_account= TRUE;
            }
          }
        } else {
          if($this->acl_is_removeable()){
            $this->is_account= FALSE;
          }
        }
      }
    }
  }

  function get_multi_edit_values()
  {
    $ret = plugin::get_multi_edit_values();
    if(in_array_strict("webdav",$this->multi_boxes)){
      $ret['is_account'] = $this->is_account;
    }
    return($ret);
  }

  function set_multi_edit_values($values)
  {
    plugin::set_multi_edit_values($values);
    if(isset($values['is_account'])){
      $this->is_account = $values['is_account'];
    }
  }

  function init_multiple_support($attrs,$all)
  {
    plugin::init_multiple_support($attrs,$all);
    if(isset($attrs['objectClass']) && in_array_strict("gosaWebDAVAccount",$attrs['objectClass'])){
      $this->is_account = TRUE;
    }
  }
}


?>
