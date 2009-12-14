==========================================================
 ``gitty`` -- github like managing system for ``gitosis``
==========================================================
  
  Gitty and gitosis will give you a nice and slick private repository manager.

Requirements
============

Requires an install of gitosis. You can get it at http://github.com/res0nat0r/gitosis

Installation
============

We are still in development but will update this as we go public. Please look into contributing below.

Getting started
===============

Clone the app into your machine. 

Extract the ``home.zip`` from the root directory and migrate. Sign in using the current default settings.

  username: daifu
  password: 123456
  
The ``home.zip`` will generate a gitosis build inside the rails root. The ``home`` directory will be created in the root directory similar to what a real gitosis build would have. It will generate a tree like below.

  `----RAILS_ROOT
   |
   `---home
      |
      `----git
          |
          `----repositories
              |
              `----gitosis-admin.git
              |
              `----daifu
                        

Authors
=======

    * William Estoque william.estoque@gmail.com
    * Daifu Ye daifu.ye@gmail.com

License
=======

MIT