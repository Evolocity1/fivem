DP = {}

DP.Expressions = {
   ["En colère"] = {"Expression", "mood_angry_1"},
   ["Ivre"] = {"Expression", "mood_drunk_1"},
   ["Stupide"] = {"Expression", "pose_injured_1"},
   ["Électrocuté"] = {"Expression", "electrocuted_1"},
   ["Grincheux 1"] = {"Expression", "effort_1"},
   ["Grincheux 2"] = {"Expression", "mood_drivefast_1"},
   ["Grincheux 3"] = {"Expression", "pose_angry_1"},
   ["Heureux"] = {"Expression", "mood_happy_1"},
   ["Blessé"] = {"Expression", "mood_injured_1"},
   ["Joyeux"] = {"Expression", "mood_dancing_low_1"},
   ["Respiration de la bouche"] = {"Expression", "smoking_hold_1"},
   ["Ne jamais cligner des yeux"] = {"Expression", "pose_normal_1"},
   ["Un oeil"] = {"Expression", "pose_aiming_1"},
   ["Sous le choc"] = {"Expression", "shocked_1"},
   ["Sous le choc2"] = {"Expression", "shocked_2"},
   ["En train de dormir"] = {"Expression", "mood_sleeping_1"},
   ["En train de dormir2"] = {"Expression", "dead_1"},
   ["En train de dormir3"] = {"Expression", "dead_2"},
   ["Suffisant(e)"] = {"Expression", "mood_smug_1"},
   ["Spéculatif"] = {"Expression", "mood_aiming_1"},
   ["Stressé"] = {"Expression", "mood_stressed_1"},
   ["Bouder"] = {"Expression", "mood_sulk_1"},
   ["Bizarre"] = {"Expression", "effort_2"},
   ["Bizarre2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Mastodonte"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Brave"] = {"move_m@brave"},
  ["Décontracté"] = {"move_m@casual@a"},
  ["Décontracté 2"] = {"move_m@casual@b"},
  ["Décontracté 3"] = {"move_m@casual@c"},
  ["Décontracté 4"] = {"move_m@casual@d"},
  ["Décontracté 5"] = {"move_m@casual@e"},
  ["Décontracté 6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Police"] = {"move_m@business@a"},
  ["Police 2"] = {"move_m@business@b"},
  ["Police 3"] = {"move_m@business@c"},
  ["Femme par défaut"] = {"move_f@multiplayer"},
  ["Homme par défaut"] = {"move_m@multiplayer"},
  ["Ivre"] = {"move_m@drunk@a"},
  ["Ivre léger"] = {"move_m@drunk@slightlydrunk"},
  ["Ivre 2"] = {"move_m@buzzed"},
  ["Ivre Mort"] = {"move_m@drunk@verydrunk"},
  ["Femme"] = {"move_f@femme@"},
  ["Feu"] = {"move_characters@franklin@fire"},
  ["Feu 2"] = {"move_characters@michael@fire"},
  ["Feu 3"] = {"move_m@fire"},
  ["Fuir"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster 2"] = {"move_m@gangster@ng"},
  ["Gangster 3"] = {"move_m@gangster@var_e"},
  ["Gangster 4"] = {"move_m@gangster@var_f"},
  ["Gangster 5"] = {"move_m@gangster@var_i"},
  ["S'enjailler"] = {"anim@move_m@grooving@"},
  ["Garde"] = {"move_m@prison_gaurd"},
  ["Menotte par devant"] = {"move_m@prisoner_cuffed"},
  ["Talons"] = {"move_f@heels@c"},
  ["Talons 2"] = {"move_f@heels@d"},
  ["Randonnée"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Se dépêcher"] = {"move_f@hurry@a"},
  ["Concierge"] = {"move_p_m_zero_janitor"},
  ["Concierge 2"] = {"move_p_m_zero_slow"},
  ["Faire du jogging"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester 2"] = {"move_lester_caneup"},
  ["Croqueuse d'homme"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Fricé"] = {"move_m@money"},
  ["Musclé"] = {"move_m@muscle@a"},
  ["Chic"] = {"move_m@posh@"},
  ["Chic 2"] = {"move_f@posh@"},
  ["Rapide"] = {"move_m@quick"},
  ["Coureur"] = {"female_fast_runner"},
  ["Triste"] = {"move_m@sad@a"},
  ["Impertinent"] = {"move_m@sassy"},
  ["Impertinent 2"] = {"move_f@sassy"},
  ["Effrayé"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Ombreux"] = {"move_m@shadyped@a"},
  ["Lent"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Dur"] = {"move_m@tough_guy@"},
  ["Dur 2"] = {"move_f@tough_guy@"},
  ["Poubelle"] = {"clipset@move@trash_fast_turn"},
  ["Poubelle 2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Large"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
    ["+18 Receive Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_punter", "+18 Receive Blowjob", "+18 Give Blowjob", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 30000,
        SyncOffsetFront = 0.63
    }},
    ["+18 Give Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "+18 Give Blowjob", "+18 Receive Blowjob", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 30000,
        SyncOffsetFront = 0.63
    }},
    ["+18 Street Sex Male"] = {"misscarsteal2pimpsex", "shagloop_pimp", "+18 Street Sex Male", "+18 Street Sex Female", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        SyncOffsetFront = 0.50
    }},
    ["+18 Street Sex Female"] = {"misscarsteal2pimpsex", "shagloop_hooker", "+18 Street Sex Female", "+18 Street Sex Male", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        SyncOffsetFront = -0.50
    }},
    ["+18 Follar (Hombre)"] = {"rcmpaparazzo_2", "shag_loop_a", "+18 Follar (Hombre)", "+18 Follar (Mujer)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        SyncOffsetFront = 0.50
    }},
    ["+18 Follar (Mujer)"] = {"rcmpaparazzo_2", "shag_loop_poppy", "+18 Follar (Mujer)", "+18 Follar (Hombre)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        SyncOffsetFront = 0.50
    }},
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["hug3"] = {"misscarsteal2chad_goodbye", "chad_armsaround_chad", "Hug 3", "hug4", AnimationOptions =
   {
     EmoteMoving = false,
     EmoteLoop = true,
     SyncOffsetFront = 0.05,
   }},
   ["hug4"] = {"misscarsteal2chad_goodbye", "chad_armsaround_girl", "Hug 4", "hug3", AnimationOptions =
   {
     EmoteMoving = false,
     EmoteLoop = true,
     SyncOffsetFront = 0.13
   }},
   ["kiss"] = {"hs3_ext-20", "cs_lestercrest_3_dual-20", "kiss", "kiss2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 4000,
       SyncOffsetFront = 0.40,
   }},
   ["kiss2"] = {"hs3_ext-20", "csb_georginacheng_dual-20", "kiss2", "kiss", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 4000,
       SyncOffsetFront = 0.40,
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Fréro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Fréro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["give"] = {"mp_common", "givetake1_a", "Donner quelque chose", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Donner quelque chose 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Lancer une fausse balle de Baseball", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Frapper une fausse balle de Baseball", "baseball"},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Faire semblant d'être braquer par quelqu'un", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Frapper quelqu'un", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Se faire frapper par quelqu'un", "punch"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Recevoir un coup de tete par quelqu'un", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Giffle retourner", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Se prendre une giffle", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Se prendre une giffle retourner", "slap2"},
}

DP.Dances = {
    
   -- Custom Dances: Divine
   ["ddance1"] = {"divined@dances@new", "ddance1", "Divined Dance 1", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance2"] = {"divined@dances@new", "ddance2", "Divined Dance 2", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance3"] = {"divined@dances@new", "ddance3", "Divined Dance 3", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance4"] = {"divined@dances@new", "ddance4", "Divined Dance 4", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance5"] = {"divined@dances@new", "ddance5", "Divined Dance 5", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance6"] = {"divined@dances@new", "ddance6", "Divined Dance 6", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance7"] = {"divined@dances@new", "ddance7", "Divined Dance 7", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance8"] = {"divined@dances@new", "ddance8", "Divined Dance 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance9"] = {"divined@dances@new", "ddance9", "Divined Dance 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance10"] = {"divined@dances@new", "ddance10", "Divined Dance 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance11"] = {"divined@dances@new", "ddance11", "Divined Dance 11", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance12"] = {"divined@dances@new", "ddance12", "Divined Dance 12", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["ddance13"] = {"divined@dances@new", "ddance13", "Divined Dance 13", AnimationOptions =
   {
      EmoteLoop = true
   }},

   -- Version Two
   ["divdance1"] = {"divined@dancesv2@new", "divdance1", "Divined Dance 1", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance2"] = {"divined@dancesv2@new", "divdance2", "Divined Dance 2", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance3"] = {"divined@dancesv2@new", "divdance3", "Divined Dance 3", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance4"] = {"divined@dancesv2@new", "divdance4", "Divined Dance 4", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance5"] = {"divined@dancesv2@new", "divdance5", "Divined Dance 5", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance6"] = {"divined@dancesv2@new", "divdance6", "Divined Dance 6", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance7"] = {"divined@dancesv2@new", "divdance7", "Divined Dance 7", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance8"] = {"divined@dancesv2@new", "divdance8", "Divined Dance 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance9"] = {"divined@dancesv2@new", "divdance9", "Divined Dance 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance10"] = {"divined@dancesv2@new", "divdance10", "Divined Dance 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance11"] = {"divined@dancesv2@new", "divdance11", "Divined Dance 11", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance12"] = {"divined@dancesv2@new", "divdance12", "Divined Dance 12", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance13"] = {"divined@dancesv2@new", "divdance13", "Divined Dance 13", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divdance14"] = {"divined@dancesv2@new", "divdance14", "Divined Dance 14", AnimationOptions =
   {
      EmoteLoop = true
   }},
   -- Divine Breakdance
   ["divbdance1"] = {"divined@breakdances@new", "divbdance1", "Divined Break Dance 1", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance2"] = {"divined@breakdances@new", "divbdance2", "Divined Break Dance 2", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance3"] = {"divined@breakdances@new", "divbdance3", "Divined Break Dance 3", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance4"] = {"divined@breakdances@new", "divbdance4", "Divined Break Dance 4", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance5"] = {"divined@breakdances@new", "divbdance5", "Divined Break Dance 5", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance6"] = {"divined@breakdances@new", "divbdance6", "Divined Break Dance 6", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance7"] = {"divined@breakdances@new", "divbdance7", "Divined Break Dance 7", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance8"] = {"divined@breakdances@new", "divbdance8", "Divined Break Dance 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance9"] = {"divined@breakdances@new", "divbdance9", "Divined Break Dance 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance10"] = {"divined@breakdances@new", "divbdance10", "Divined Break Dance 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance11"] = {"divined@breakdances@new", "divbdance11", "Divined Break Dance 11", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance12"] = {"divined@breakdances@new", "divbdance12", "Divined Break Dance 12", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance13"] = {"divined@breakdances@new", "divbdance13", "Divined Break Dance 13", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance14"] = {"divined@breakdances@new", "divbdance14", "Divined Break Dance 14", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["divbdance15"] = {"divined@breakdances@new", "divbdance14", "Divined Break Dance 15", AnimationOptions =
   {
      EmoteLoop = true
   }},

   -- Divine Breakdance v3
   ["dbrdance1"] = {"divined@brdancesv2@new", "dbrdance1", "Divined Dance 1", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance2"] = {"divined@brdancesv2@new", "dbrdance2", "Divined Dance 2", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance3"] = {"divined@brdancesv2@new", "dbrdance3", "Divined Dance 3", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance4"] = {"divined@brdancesv2@new", "dbrdance4", "Divined Dance 4", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance5"] = {"divined@brdancesv2@new", "dbrdance5", "Divined Dance 5", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance6"] = {"divined@brdancesv2@new", "dbrdance6", "Divined Dance 6", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance7"] = {"divined@brdancesv2@new", "dbrdance7", "Divined Dance 7", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance8"] = {"divined@brdancesv2@new", "dbrdance8", "Divined Dance 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance9"] = {"divined@brdancesv2@new", "dbrdance9", "Divined Dance 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance10"] = {"divined@brdancesv2@new", "dbrdance10", "Divined Dance 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance11"] = {"divined@brdancesv2@new", "dbrdance11", "Divined Dance 11", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["dbrdance12"] = {"divined@brdancesv2@new", "dbrdance12", "Divined Dance 12", AnimationOptions =
   {
      EmoteLoop = true
   }},
    ["capoeiramove"] = {"divined@tdances@new", "dtdance4", "Capoeira Move", AnimationOptions =
    {
       EmoteLoop = true,
    }},
    ["banddance"] = {"divined@tdances@new", "dtdance1", "Band Dance", AnimationOptions =
    {
       EmoteLoop = true,
    }},
    ["bboydance"] = {"divined@tdances@new", "dtdance3", "BBoy Dance", AnimationOptions =
    {
       EmoteLoop = true,
    }},
    ["bellydance"] = {"custom@bellydance", "bellydance", "Belly Dance", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["shakasitting"] = {"anim@shaka_sit", "shaka_clip", "Kicked Back Shaka (Smos)", AnimationOptions =
{
	EmoteLoop = loop,
	EmoteMoving = false,
}},

["mstance1"] = {"anim@male_casual_stance", "casual_stance", "Casual Male Stance (Smos)", AnimationOptions =
{
	EmoteLoop = true,
	EmoteMoving = false,
}},

["mselfie1"] = {"anim@male_insta_selfie", "insta_selfie_clip", "Male Selfie 1 (Smos)", AnimationOptions =
{
	EmoteLoop = true,
	EmoteMoving = false,
}},

["bskball1"] = {"anim@male_bskball_dunk", "bskball_dunk_clip", "Basketball Dunk (Smos)", AnimationOptions =
{
        Prop = 'prop_bskball_01',
        PropBone = 24817,
        PropPlacement = {0.80, -0.17, -0.50, 90.0, -90.0, 0.0},
        EmoteMoving = false,
        EmoteLoop = true
}},

["bskball2"] = {"anim@male_bskball_photo_pose", "photo_pose_clip", "Basketball Photo Pose (Smos)", AnimationOptions =
{
    Prop = 'prop_bskball_01',
    PropBone = 24817,
    PropPlacement = {0.40, 0.17, 0.20, 90.0, -90.0, 0.0},
	EmoteLoop = true,
	EmoteMoving = false,
}},

["bskball3"] = {"anim@male_bskball_hold", "bskball_hold_clip", "Basketbal Hold (Smos)", AnimationOptions =
{
    Prop = 'prop_bskball_01',
    PropBone = 24817,
    PropPlacement = {0.20, 0.33, -0.02, -90.0, -90.0, 0.0},
    EmoteMoving = true,
    EmoteLoop = true
}},

    ["jdrill"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "mi_dance_prop_13_v1_male^3", "Drill · Male - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["cripwalk2"] = {"div@woowalk@test", "cripwalk2", "Crip gang dance ~b~drill~s~", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["bloodwalk2"] = {"div@woowalk@test", "bloodwalk2", "Blood gang dance ~r~drill~s~", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["jdrill2"] = {"anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", "mi_dance_crowd_13_v2_male^1", "Drill · Male 2 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill3"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_17_v2_male^4", "Drill · Male 3 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill4"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_15_v2_male^4", "Drill · Male 4 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6 · Female", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill5"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_15_v2_male^5", "Drill · Male 5 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jDrill6"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_17_male^5", "Drill · Male 6 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill7"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_up", "Drill · Solo 1 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
     }},
     ["jdrill8"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "med_center", "Drill · Solo 2 - ~y~Kingder~c~1.0", AnimationOptions =
     {
         EmoteLoop = true,
      }},
     ["jdrill9"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_down", "Drill · Solo 3 - ~y~Kingder~c~1.0", AnimationOptions =
      {
          EmoteLoop = true,
       }}, 
       ["jdrill10"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_center", "Drill · Solo 4 - ~y~Kingder~c~1.0", AnimationOptions =
      {
          EmoteLoop = true,
       }}, 
    ["jDrill11"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_left_down", "Drill · Solo 5 - ~y~Kingder~c~1.0", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["woowalk"] = {"div@woowalk@test", "woowalk", "Woo Walk", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["drilldance"] = {"div@woowalk@test", "drilldance", "Drill Dance", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["sturdy2"] = {"div@woowalk@test", "sturdy2", "Get Sturdy", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["blixkytwirl2"] = {"div@woowalk@test", "blixkytwirl2", "Blixky Twirl", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["catdaddy"] = {"div@woowalk@test", "catdaddy", "Cat Daddy", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["popdance"] = {"div@woowalk@test", "popdance", "Pop Smoke Dance", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["toprock"] = {"div@woowalk@test", "toprock", "Toprock", AnimationOptions =
    {
        EmoteLoop = true
    }},
        ["crossbounce"] = {"custom@crossbounce", "crossbounce", "Cross bounce(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["dontstart"] = {"custom@dont_start", "dont_start", "Dont Start(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["floss"] = {"custom@floss", "floss", "Floss(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["orangejustice"] = {"custom@orangejustice", "orangejustice", "Orange Justice(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["renegade"] = {"custom@renegade", "renegade", "Renegade(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["rickroll"] = {"custom@rickroll", "rickroll", "Rick Roll(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["savage"] = {"custom@savage", "savage", "Savage(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["sayso"] = {"custom@sayso", "sayso", "Say So(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["takel"] = {"custom@take_l", "take_l", "Take the L(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["tslide"] = {"custom@toosie_slide", "toosie_slide", "Tootsie Slide", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["woahdance"] = {"divined@tdances@new", "dtdance22", "Woah", AnimationOptions =
    {
       EmoteLoop = true,
    }},
 
    ["clock"] = {"custom@around_the_clock", "around_the_clock", "Around the clock(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["dancemoves"] = {"custom@dancemoves", "dancemoves", "Dance moves(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["discodance"] = {"custom@disco_dance", "disco_dance", "Disco Dance(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["electroshuffle"] = {"custom@electroshuffle_original", "electroshuffle_original", "Electro Shuffle(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["electroshuffle2"] = {"custom@electroshuffle", "electroshuffle", "Electro Shuffle 2(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["fresh"] = {"custom@fresh_fortnite", "fresh_fortnite", "Fresh(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["gylphic"] = {"custom@gylphic", "gylphic", "Glyphic(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["hitit"] = {"custom@hitit", "hitit", "Hit It(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["inparty"] = {"custom@in_da_party", "in_da_party", "In Da Party(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["robotdance"] = {"custom@robotdance_fortnite", "robotdance_fortnite", "Robot Dance(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["frightfunk"] = {"custom@frightfunk", "frightfunk", "Fright Funk(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["gloss"] = {"custom@gloss", "gloss", "Gloss(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["lastforever"] = {"custom@last_forever", "last_forever", "Last Forever(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["smoothmoves"] = {"custom@smooth_moves", "smooth_moves", "Smooth moves(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["introducing"] = {"custom@introducing", "introducing", "Introducing...(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["bellydance2"] = {"custom@bellydance2", "bellydance2", "·Belly Dance 2", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["footwork"] = {"custom@footwork", "footwork", "·Footwork", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["headspin"] = {"custom@headspin", "headspin", "·Headspin", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = false,
    }},

    ["pumpup"] = {"custom@hiphop_pumpup", "hiphop_pumpup", "·Hiphop Pumpup", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["hiphop_yeah"] = {"custom@hiphop_yeah", "hiphop_yeah", "·Hiphop Yeah", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = false,
    }},

    ["salsatime"] = {"custom@salsatime", "salsatime", "·Salsa Time", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["samba"] = {"custom@samba", "samba", "·Samba", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["shockdance"] = {"custom@shockdance", "shockdance", "·Shock Dance", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["specialdance"] = {"custom@specialdance", "specialdance", "·Special Dance", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},

    ["toetwist"] = {"custom@toetwist", "toetwist", "·Toe twist", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},
    ["salsa"] = {"custom@salsa", "salsa", "Salsa", AnimationOptions =
    {
       EmoteLoop = true,
  
    }},
    ["hiphopslide"] = {"custom@hiphop_slide", "hiphop_slide", "HipHop Slide", AnimationOptions =
     {
        EmoteMoving = false,
        EmoteLoop = true,
     }},
     
     ["hiphop1"] = {"custom@hiphop1", "hiphop1", "HipHop 1", AnimationOptions =
     {
        EmoteMoving = false,
        EmoteLoop = true,
     }},
     
     ["hiphop2"] = {"custom@hiphop2", "hiphop2", "HipHop 2", AnimationOptions =
     {
        EmoteMoving = false,
        EmoteLoop = true,
     }},
     
     ["hiphop3"] = {"custom@hiphop3", "hiphop3", "HipHop 3", AnimationOptions =
     {
        EmoteMoving = false,
        EmoteLoop = true,
     }},
     
     ["hiphopold"] = {"custom@hiphop90s", "hiphop90s", "HipHop Old", AnimationOptions =
     {
        EmoteMoving = false,
        EmoteLoop = true,
     }},
     ["gangnamstyle"] = {"custom@gangnamstyle", "gangnamstyle", "Gangnamstyle", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
  
    }},
    ["makarena"] = {"custom@makarena", "makarena", "Makarena", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
  
    }},
    ["maraschino"] = {"custom@maraschino", "maraschino", "Maraschino", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
  
    }},
    ["breakdance"] = {"export@breakdance", "breakdance", "Break Dance", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
  
    }},
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Danse Femme", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Danse Femme 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Danse Femme 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Danse Femme 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Danse Femme 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Danse Femme 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Danse Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Danse Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Danse Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Danse", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Danse 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Danse 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Danse 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Danse Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Danse Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Danse timide", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Danse timide 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Danse lente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Danse idiote 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Danse 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Danse 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Danse 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Danse idiote", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Danse idiote 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Danse idiote 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Danse idiote 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Danse idiote 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Danse idiote 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Danse 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Danse idiote 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Danse idiote 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Danse 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Danse avec bâtons lumineux", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Danse avec bâtons lumineux 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Danse avec bâtons lumineux 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Danse de cheval", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Danse de cheval 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Danse de cheval 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
}

DP.PropEmotes = {
   ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Tenir un parapluie", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
--------------------------------------------
["crackpipe"] = {"timetable@ron@ig_4_smoking_meth", "onemorehit", "Crackpipe", AnimationOptions = {
    Prop = "prop_cs_crackpipe",
    PropBone = 28422,
    PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    SecondProp = 'p_cs_lighter_01',
    SecondPropBone = 60309,
    SecondPropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    EmoteLoop = true,
    
}},
["carryfoodbag"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag", AnimationOptions =
{
Prop = "prop_food_bs_bag_01",
PropBone = 57005,
PropPlacement = {0.3300, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
EmoteLoop = true,
EmoteMoving = true,

}},
["carryfoodbag2"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag 2", AnimationOptions =
{
Prop = "prop_food_cb_bag_01",
PropBone = 57005,
PropPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
EmoteLoop = true,
EmoteMoving = true,

}},
["carryfoodbag3"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag 3", AnimationOptions =
{
Prop = "prop_food_bag1",
PropBone = 57005,
PropPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
EmoteLoop = true,
EmoteMoving = true,

}},
["carrypizza"] = {"anim@heists@box_carry@", "idle", "Carry Pizza Box", AnimationOptions =
{
Prop = "prop_pizza_box_01",
PropBone = 28422,
PropPlacement = {0.0100, -0.2600, -0.200, 20.0, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["carrypizza2"] = {"anim@heists@box_carry@", "idle", "Carry Pizza Box 2", AnimationOptions =
{
Prop = "prop_pizza_box_02",
PropBone = 28422,
PropPlacement = {0.0100, -0.1000, -0.1590,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray"] = {"anim@heists@box_carry@", "idle", "Food Tray 1", AnimationOptions =
{
Prop = "prop_food_bs_tray_03",
PropBone = 28422,
PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray2"] = {"anim@heists@box_carry@", "idle", "Food Tray 2", AnimationOptions =
{
Prop = "prop_food_bs_tray_02",
PropBone = 28422,
PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray3"] = {"anim@heists@box_carry@", "idle", "Food Tray 3", AnimationOptions =
{
Prop = "prop_food_cb_tray_02",
PropBone = 28422,
PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray4"] = {"anim@heists@box_carry@", "idle", "Food Tray 4", AnimationOptions =
{
Prop = "prop_food_tray_02",
PropBone = 28422,
PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray5"] = {"anim@heists@box_carry@", "idle", "Food Tray 5", AnimationOptions =
{
Prop = "prop_food_tray_03",
PropBone = 28422,
PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray6"] = {"anim@heists@box_carry@", "idle", "Food Tray 6", AnimationOptions =
{
Prop = "prop_food_bs_tray_02",
PropBone = 57005,
PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
SecondProp = 'prop_food_bs_tray_03',
SecondPropBone =18905,
SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray7"] = {"anim@heists@box_carry@", "idle", "Food Tray 7", AnimationOptions =
{
Prop = "prop_food_cb_tray_02",
PropBone = 57005,
PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
SecondProp = 'prop_food_cb_tray_02',
SecondPropBone =18905,
SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray8"] = {"anim@heists@box_carry@", "idle", "Food Tray 8", AnimationOptions =
{
Prop = "prop_food_tray_02",
PropBone = 57005,
PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
SecondProp = 'prop_food_tray_03',
SecondPropBone =18905,
SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray9"] = {"anim@heists@box_carry@", "idle", "Food Tray 9", AnimationOptions =
{
Prop = "prop_food_tray_02",
PropBone = 57005,
PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
SecondProp = 'prop_food_tray_02',
SecondPropBone =18905,
SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray10"] = {"anim@move_f@waitress", "idle", "Food Tray 10", AnimationOptions =
{
Prop = "prop_food_bs_tray_02",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray11"] = {"anim@move_f@waitress", "idle", "Food Tray 11", AnimationOptions =
{
Prop = "prop_food_bs_tray_02",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray12"] = {"anim@move_f@waitress", "idle", "Food Tray 12", AnimationOptions =
{
Prop = "prop_food_bs_tray_03",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray13"] = {"anim@move_f@waitress", "idle", "Food Tray 13", AnimationOptions =
{
Prop = "prop_food_cb_tray_02",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray14"] = {"anim@move_f@waitress", "idle", "Food Tray 14", AnimationOptions =
{
Prop = "prop_food_tray_02",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["foodtray15"] = {"anim@move_f@waitress", "idle", "Food Tray 15", AnimationOptions =
{
Prop = "prop_food_tray_02",
PropBone = 28422,
PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["idcard"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Id Card", AnimationOptions = {
Prop = "p_ld_id_card_002",
PropWait = 500,
PropBone = 60309,
PropPlacement = {0.0, 0.0, 0.0, 0.0, 90.0, 0.0},
EmoteStuck = true,
PropGive = false,
}},
["lawnchair"] = { "timetable@ron@ig_5_p3", "ig_5_p3_base", "Lawnchair", AnimationOptions = {
Prop          = "prop_skid_chair_02",
PropBone      = 0,
PropPlacement = { 0.025, -0.2, -0.1, 45.0, -5.0, 180.0 },
EmoteLoop     = true,
EmoteMoving   = false,
GetStoredAnimModel = 'skidchair',
PropGive      = true,
}},
["lawnchair2"] = { "timetable@reunited@ig_10", "base_amanda", "Lawnchair 2", AnimationOptions = {
Prop          = "prop_skid_chair_02",
PropBone      = 0,
PropPlacement = { 0.025, -0.15, -0.1, 45.0, 5.0, 180.0 },
EmoteLoop     = true,
EmoteMoving   = false,
GetStoredAnimModel = 'skidchair',
PropGive      = true,
}},
["lawnchair3"] = { "timetable@ron@ig_3_couch", "base", "Lawnchair 3", AnimationOptions = {
Prop          = "prop_skid_chair_02",
PropBone      = 0,
PropPlacement = { -0.05, 0.0, -0.2, 5.0, 0.0, 180.0 },
EmoteLoop     = true,
EmoteMoving   = false,
GetStoredAnimModel = 'skidchair',
PropGive      = true,
}},
["shopbag"] = {"move_weapon@jerrycan@generic", "idle", "Shopping Bag", AnimationOptions =
{
Prop = "vw_prop_casino_shopping_bag_01a",
PropBone = 28422,
PropPlacement = {0.24, 0.03, -0.04, 0.00, -90.00, 10.00},
EmoteLoop = true,
EmoteMoving = true,

}},
["shopbag2"] = {"move_weapon@jerrycan@generic", "idle", "Shopping Bag 2", AnimationOptions =
{
Prop = "prop_shopping_bags02",
PropBone = 28422,
PropPlacement = {0.05, 0.02, 0.00, 178.80, 91.19, 9.97},
EmoteLoop = true,
EmoteMoving = true,

}},
["shopbag3"] = {"move_weapon@jerrycan@generic", "idle", "Shopping Bag 3", AnimationOptions =
{
Prop = "prop_cs_shopping_bag",
PropBone = 28422,
PropPlacement = {0.24, 0.03, -0.04, 0.00, -90.00, 10.00},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign"] = {"rcmnigel1d", "base_club_shoulder", "Sign Stop", AnimationOptions =
{
Prop = "prop_sign_road_01a",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign2"] = {"rcmnigel1d", "base_club_shoulder", "Sign Yield", AnimationOptions =
{
Prop = "prop_sign_road_02a",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign3"] = {"rcmnigel1d", "base_club_shoulder", "Sign Hospital", AnimationOptions =
{
Prop = "prop_sign_road_03d",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign4"] = {"rcmnigel1d", "base_club_shoulder", "Sign Parking", AnimationOptions =
{
Prop = "prop_sign_road_04a",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign5"] = {"rcmnigel1d", "base_club_shoulder", "Sign Parking", AnimationOptions =
{
Prop = "prop_sign_road_04w",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign6"] = {"rcmnigel1d", "base_club_shoulder", "Sign Pedestrian", AnimationOptions =
{
Prop = "prop_sign_road_05a",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["sign7"] = {"rcmnigel1d", "base_club_shoulder", "Sign Street", AnimationOptions =
{
Prop = "prop_sign_road_05t",
PropBone = 60309,
PropPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
EmoteLoop = true,
EmoteMoving = true,

}},
["trolley1"] = {"anim@heists@box_carry@", "idle", "Trolley 1", AnimationOptions =
{
Prop = "prop_rub_trolley01a",
PropBone = 28422,
PropPlacement = {-0.00, -0.475, -0.8, 195.0, 180.0, 180.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["trolley2"] = {"anim@heists@box_carry@", "idle", "Trolley 2", AnimationOptions =
{
Prop = "prop_skid_trolley_1",
PropBone = 28422,
PropPlacement = {-0.00, -0.475, -0.8, 195.0, 180.0, 180.0},
EmoteLoop = true,
EmoteMoving = true,

}},
["trolley3"] = {"anim@heists@box_carry@", "idle", "Trolley 3", AnimationOptions =
{
Prop = "prop_skid_trolley_2",
PropBone = 28422,
PropPlacement = {-0.00, -0.475, -0.8, 195.0, 180.0, 180.0},
EmoteLoop = true,
EmoteMoving = true,

}},---------------------------------------------------------

   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Ecrire sur un bloc note", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Boîte", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Tenir une rose", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Fumer 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Fumer 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Fumer 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["balloon"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Faire un ballon", AnimationOptions =
   {
       Prop = 'prop_sh_cigar_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bang", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "Tenir une valise", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "Tenir une valise 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Photo d'identité", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir un café", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leandrugs"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir une bouteille de lean", AnimationOptions =
   {
       Prop = 'prop_cs_script_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leandrugs2"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir une bouteille de lean 2", AnimationOptions =
   {
       Prop = 'prop_cs_script_bottle_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leandrugs3"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir une bouteille de lean 3", AnimationOptions =
   {
       Prop = 'ng_proc_sodabot_01a',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.20, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir un verre de whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Biére", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir une tasse", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Manger un donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Manger un sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tenir une canette de soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Mager une bar de chocolat", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Tenir un verre de vin", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Tenir un verre de champagne vide", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Verre de champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Fumer un cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Fumer une cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Jouer de la guitare", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Jouer de la guitare en movement", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Jouer de la guitare éléctrique", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Jouer de la guitare éléctrique 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Livre", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet de fleur", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Tenir une péluche", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Sac à dos", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard"] = {"missfam4", "base", "Consulter un bloc note", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Consulter une carte GPS", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Pancarte de SDF", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Faire pleuvoir des billets", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Appareil photo", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Arroser de champagne", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Fumer un joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Fumer une cigarette", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "Malette à tenir", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Consulter une tablette", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Consulter une tablette 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Appeler quelqu'un", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phone"] = {"cellphone@", "cellphone_text_read_base", "Regarder son téléphone", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Nettoyer une table", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Nettoyer une vitre", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}



































DP.Gestes = {
    ["dabloop"] = {"divined@tdances@new", "dtdance13", "Dab Loop", AnimationOptions =
    {
       EmoteLoop = true,
    }},
    ["dab"] = { "custom@dab", "dab", "Dab", AnimationOptions =
    {
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["cantsee"] = { "custom@cant_see", "cant_see", "Can't See", AnimationOptions =
    {
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["hug3"] = {"misscarsteal2chad_goodbye", "chad_armsaround_chad", "Câlin 3",  AnimationOptions =
    {
      EmoteMoving = false,
      EmoteLoop = true,
      SyncOffsetFront = 0.05,
    }},
   --  Custom Gangsigns
   ["gsign1"] = {"custom@gsign_01", "gsign_01", "Gang Sign 1", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign2"] = {"custom@gsign_02", "gsign_02", "Gang Sign 2", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign3"] = {"custom@gsign_03", "gsign_03", "Gang Sign 3", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign4"] = {"custom@gsign_04", "gsign_04", "Gang Sign 4", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign5"] = {"custom@gsign_05", "gsign_05", "Gang Sign 5", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign6"] = {"custom@gsign_06", "gsign_06", "Gang Sign 6", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign7"] = {"custom@gsign_07", "gsign_07", "Gang Sign 7", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign8"] = {"custom@gsign_08", "gsign_08", "Gang Sign 8", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign9"] = {"custom@gsign_09", "gsign_09", "Gang Sign 9", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign10"] = {"custom@gsign_10", "gsign_10", "Gang Sign 10", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign11"] = {"custom@gsign_11", "gsign_11", "Gang Sign 11", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign12"] = {"custom@gsign_12", "gsign_12", "Gang Sign 12", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign13"] = {"custom@gsign_13", "gsign_13", "Gang Sign 13", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign14"] = {"custom@gsign_14", "gsign_14", "Gang Sign 14", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign15"] = {"custom@mgsign_01", "mgsign_01", "Gang Sign 15", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign16"] = {"custom@mgsign_02", "mgsign_02", "Gang Sign 16", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign17"] = {"custom@mgsign_03", "mgsign_03", "Gang Sign 17", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign18"] = {"custom@mgsign_04", "mgsign_04", "Crip Sign", AnimationOptions =
   {
     EmoteLoop = true,
     EmoteMoving = false,
   }},
   ["gsign19"] = {"custom@gsign_26", "gsign_26", "Gang Sign 19", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["gsign20"] = {"custom@gsign_27", "gsign_27", "Gang Sign 20", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["gsign21"] = {"custom@gsign_28", "gsign_28", "Gang Sign 21", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["gsign22"] = {"custom@gsign_29", "gsign_29", "Gang Sign 22", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign23"] = {"custom@gsign_30", "gsign_30", "Gang Sign 23", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["gsign24"] = {"custom@gsign_31", "gsign_31", "Gang Sign 24", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign25"] = {"custom@gsign_32", "gsign_32", "Gang Sign 25", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign26"] = {"custom@gsign_33", "gsign_33", "Gang Sign 26", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign27"] = {"custom@gsign_34", "gsign_34", "Gang Sign 27", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign28"] = {"custom@gsign_35", "gsign_35", "Gang Sign 28", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign29"] = {"custom@gsign_36", "gsign_36", "Gang Sign 29", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["gsign30"] = {"custom@gsign_37", "gsign_37", "Gang Sign 30", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["hug4"] = {"misscarsteal2chad_goodbye", "chad_armsaround_girl", "Câlin 4", AnimationOptions =
    {
      EmoteMoving = false,
      EmoteLoop = true,
      SyncOffsetFront = 0.13
    }},
    ["kiss"] = {"hs3_ext-20", "cs_lestercrest_3_dual-20", "kiss", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 4000,
        SyncOffsetFront = 0.40,
    }},
    ["kiss2"] = {"hs3_ext-20", "csb_georginacheng_dual-20", "kiss2", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 4000,
        SyncOffsetFront = 0.40,
    }},
    ["mgangsigns_1"] = {"mikey@gangsigns2@new", "mgangsigns_1", "Gangsign 1", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_2"] = {"mikey@gangsigns2@new", "mgangsigns_2", "Gangsign 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_3"] = {"mikey@gangsigns2@new", "mgangsigns_3", "Gangsign 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_4"] = {"mikey@gangsigns2@new", "mgangsigns_4", "Gangsign 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_5"] = {"mikey@gangsigns2@new", "mgangsigns_5", "Gangsign 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_6"] = {"mikey@gangsigns2@new", "mgangsigns_6", "Gangsign 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_7"] = {"mikey@gangsigns2@new", "mgangsigns_7", "Gangsign 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_8"] = {"mikey@gangsigns2@new", "mgangsigns_8", "Gangsign 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mgangsigns_9"] = {"mikey@gangsigns2@new", "mgangsigns_9", "Gangsign 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Ajustez sa chemise", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Disputer", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Toi là ! Je vais t'éclater !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Faire des gestes de la main", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Applaudir joyeusement", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Applaudir comme un débile", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "C'est mon frère sa !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Tousser", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Applaudissement", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Toi là ! Je vais te crever !"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Je vais te trancher la gorge"},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Ah merde !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Put*** !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Manger", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Oh lala..", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Hein ? Pas possible..", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Quel malheur..", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Quel idiot..", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Faire un fuck", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Faire un double fuck", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Montrer ses muscles"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Faire un fuck à l'horizon", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Faire un double fuck à l'horizon", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Signe de gang", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Signe de gang 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Poignée de main", "Tscheck moi sa", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Poignée de main 2", "Tscheck mon pote !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},

   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Lever les mains en l'air", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Coup de boule", "headbutted"},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Serrer dans les bras", "Câlin", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Serrer dans les bras 2", "Câlin 2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Clown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Utiliser une clée", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Toquer à une porte", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Toquer fort à une porte", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Se craquer les doigts", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "S'aggriper à quelqu'un", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Faire du stop", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Moi ?", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Signe métal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Ravi de te voir !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Non pas du tout !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Non de la tête", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Se décrotter le nez", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "Absolument pas", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace and love", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace and love 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pickup"] = {"random@domestic", "pickup_low", "Ramasser"},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Hé toi là !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Tu restes ici", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Pointe vers la droite", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Hé toi !", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Main sur le holster", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salut de l'armée", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salut de l'armée 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salut de l'armée 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Avoir peur", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Avoir peur 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "Bras d'honneur", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Enlever la poussière au sol", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Hein ?", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Quoi ?", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Giffler quelqu'un", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Applaudir doucement", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Applaudir doucement 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Applaudir au ralenti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Se sentir la main", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Sa pue", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Hm..", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Se tenir le menton", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think3"] = {"timetable@tracy@ig_8@base", "base", "Se gratter l'oeil", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Croiser les bras en ce tenant le menton", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Se gratter la tête", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Double pouce en l'air", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Pouce en l'air en souriant", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Pouce en l'air", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Coucou !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Salut de reine", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Lever un bras comme une star", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Salut avec les bras en l'air", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave5"] = {"friends@frj@ig_1", "wave_b", "Hé c'est moi !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave6"] = {"friends@frj@ig_1", "wave_c", "Je suis là", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave7"] = {"friends@frj@ig_1", "wave_d", "Hé oh", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave8"] = {"friends@frj@ig_1", "wave_e", "Salut !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Hey !", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["whistle"] = {"taxi_hail", "hail_taxi", "Sifflé", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Sifflé 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}

DP.Autres = {
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Se ré-habillez correctement", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Se prendre pour un avion", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Faire le chien par terre"},
   ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Flou", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Faire l'oiseau"},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Plein de bisous"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Embrasser", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Qu'est-ce qu'y a", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Célébrer", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Faire la poule", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Danseuse étoile"},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Danse du poisson", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Dance privée", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Dance privée 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Dance privée 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Superman", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "Mort de rire", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "Mort de rire 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Contrôle de la pensée", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Contrôle de la pensée 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Méfiant", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Méfiant 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Méfiant 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "faire pipi", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Pousser sur le côté", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Tirer le maillot de quelqu'un", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Pousser", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Pousser 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Faire le lapin"}, 
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "S'asseoir", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "S'asseoir 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "S'asseoir 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "S'asseoir 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "S'asseoir 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "S'asseoir 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "S'asseoir 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "S'asseoir 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "S'asseoir 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "S'asseoir Timidement", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "S'asseoir Tristement", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "S'asseoir effrayé", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "S'asseoir effrayé 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "S'asseoir effrayé 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "S'asseoir bourré", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "S'asseoir sur une chaise"},
   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "S'asseoir sur une chaise 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "S'asseoir sur une chaise 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "S'asseoir sur une chaise 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "S'asseoir sur une chaise 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "S'asseoir sur une chaise 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jsitchair7"] = {"timetable@reunited@ig_10", "isthisthebest_jimmy", "Sit Chair 7", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["jsitchair8"] = {"timetable@michael@on_sofabase", "sit_sofa_base", "Sit Chair 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["jsitchair9"] = {"timetable@trevor@smoking_meth@base", "base", "Sit Chair 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["jsitchair10"] = {"timetable@tracy@ig_7@base", "base", "Sit Chair 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "S'asseoir sur une chaise de côté", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spiderman", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Pointer avec son arme", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "Gros mal de tête", "Trébucher", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Électrocuté", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Super héro", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Super héro 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Pointé une arme comme un gangster", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Se regarder dans le mirroir", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Se regarder dans le mirroir 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Se regarder dans le mirroir 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uncuff"] = {"mp_arresting", "a_uncuff", "Se gratter la main", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Regarder un article à la vitrine"},
}

DP.Activites = {
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Guitare dans le vent"},
   ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Taper au marteau"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Piano dans le vent"},
   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Merci de fin de spectacle", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["follar1"] = {"rcmpaparazzo_2", "shag_loop_a", "+18 Follar (Hombre)", AnimationOptions =
   {
        EmoteLoop = true,
        EmoteMoving = false,
   }},
   ["follar2"] = {"rcmpaparazzo_2", "shag_loop_poppy", "+18 Follar (Mujer)", AnimationOptions =
   {
        EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["mamadacoche1"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_male", "+18 Mamada en coche (Hombre)", AnimationOptions =
   {
        EmoteLoop = true,
        EmoteMoving = true,
        allowedincars =true,
   }},
   ["mamadacoche2"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_prostitute", "+18 Mamada en coche (Mujer)", AnimationOptions =
   {
        EmoteLoop = true,
       EmoteMoving = true,
       allowedincars =true,
   }},
   ["follarcoche11"] = {"mini@prostitutes@sexnorm_veh", "sex_loop_male", "+18 Follar en coche 1 (Hombre)", AnimationOptions =
   {
        EmoteLoop = true,
        EmoteMoving = false,
        allowedincars =true,
   }},
   ["follarcoche12"] = {"mini@prostitutes@sexnorm_veh", "sex_loop_prostitute", "+18 Follar en coche 1 (Mujer)", AnimationOptions =
   {
        EmoteLoop = true,
       EmoteMoving = false,
       allowedincars =true,
   }},
   ["mamada1"] = {"oddjobs@towing", "m_blow_job_loop", "+18 Mamada (Hombre)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       allowedincars =true,
   }},
   ["mamada2"] = {"oddjobs@towing", "f_blow_job_loop", "+18 Mamada (Mujer)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       allowedincars =true,
   }},
   ["follarcoche21"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", "+18 Follar en coche 2 (Hombre)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
       allowedincars =true,
   }},
   ["follarcoche22"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", "+18 Follar en coche 2 (Mujer)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
       allowedincars =true,
   }},
   ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Merci de fin de spectacle 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
    ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Fouiller une poubelle"},
	["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Félicitation"},
	["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Donnez des ordres d'attérissage"},
	["drink"] = {"mp_player_inteat@pnq", "loop", "Boire", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Ivre à en tomber"},
   ["fallover2"] = {"mp_suicide", "pistol", "Se tirer une balle dans la tête"},
   ["fallover3"] = {"mp_suicide", "pill", "Prendre du poisson"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Se prendre une balle en pleine tête"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Se prendre une droite"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Filmer avec son téléphone"},
   ["hiking"] = {"move_m@hiking", "idle", "Tenir son sac", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspecter"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "tenir un balai"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Jetez un coup d'oeil"},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Souffleur de feuilles"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Attention"},
   ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Essuyer une vitre"},
   ["mechanic"] = {"mini@repair", "fixing_a_ped", "Réparer un moteur", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "ZMechanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Réparer l'avant du véhicule", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Réparer un moteur 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Méditer", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Méditer 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Méditer 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Jouer un instrument musical"},
   ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Sortir son notepad"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Payer à la borne du parking"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Boire une bière en dansant"},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Jardinage", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostituée classe"},
   ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostituée bas de gamme"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Se nettoyer avec de l'eau"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Filmer une scène"},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Fumer une cigarette"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Fumer de la weed"},
   ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Envoyer un message"},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Taper sur un clavier", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Taper sur un clavier 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Taper sur un clavier 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Taper sur un clavier 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Se chauffer les mains autour du feu", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Agiter les bras en l'air", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Outil de soudure"},
}

DP.Positions = {
    
   --Kayra10: yeniler
   ["kselfie"] = {"murda@femalepose01", "femalepose01", "Selfie", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["knude"] = {"murda@tiddies", "tiddies", "N*de #1", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["gsigndeneme"] = {"pastelblood@animation", "pastelblood_clip", "gsigndeneme", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["gsigndeneme2"] = {"pepitosign4@animation", "pepitosign4_clip", "gsigndeneme2", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["gsigndeneme3"] = {"westsidesign@animation", "westsidesign_clip", "gsigndeneme3", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["gsigndeneme4"] = {"banks@juiceplug", "banks2", "gsigndeneme4", AnimationOptions =
   {
   EmoteLoop = true,
   EmoteMoving = false,
   }},
   ["gsigndeneme5"] = {"banks@animation", "banks1", "gsigndeneme5", AnimationOptions =
   {
   EmoteLoop = true,
   EmoteMoving = false,
   }},
   ["gsigndeneme6"] = {"nocap5@animation", "nocap5_clip", "gsigndeneme6", AnimationOptions =
   {
   EmoteLoop = true,
   EmoteMoving = false,
   }},
   ["gsigndeneme7"] = {"nocap7@animation", "nocap7_clip", "gsigndeneme7", AnimationOptions =
   {
   EmoteLoop = true,
   EmoteMoving = false,
   }},
   ["gsigndeneme8"] = {"duoanim2@animation", "duoanim2_clip", "gsigndeneme8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme9"] = {"217@aim2x@animation", "aim2x_clip", "gsigndeneme9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme10"] = {"mvpsign3@animacion", "mvpsign3_clip", "gsigndeneme10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme11"] = {"cripsgangsign@animation", "cripsgangsign_clip", "gsigndeneme11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme12"] = {"69nine@animation", "69nine_clip", "gsigndeneme12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme13"] = {"chillpose@animation", "chillpose_clip", "gsigndeneme13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme14"] = {"couple1@animation", "couple1_clip", "gsigndeneme14", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme15"] = {"couple2@animation", "couple2_clip", "gsigndeneme15", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme16"] = {"glock@animation", "dk_clip", "gsigndeneme16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme17"] = {"lean@animation", "dk_clip", "gsigndeneme17", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme18"] = {"pastelgangsign2@animation", "pastelgangsign2_clip", "gsigndeneme18", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme19"] = {"pastelpistol@animation", "pastelpistol_clip", "gsigndeneme19", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme20"] = {"maosnobolso@animation", "maosnobolso_clip", "gsigndeneme20", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme21"] = {"paspose@animation", "paspose_clip", "gsigndeneme21", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme22"] = {"cigarpose@animation", "cigarpose_clip", "gsigndeneme22", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme23"] = {"drunk@animation", "drunk_clip", "gsigndeneme23", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme24"] = {"posepis@animation", "posepis_clip", "gsigndeneme24", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme25"] = {"instapose2@animation", "instapose2_clip", "gsigndeneme25", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme26"] = {"instapose@animation", "instapose_clip", "gsigndeneme26", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme27"] = {"gangpose@animation", "gangpose_clip", "gsigndeneme27", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme28"] = {"simple@animation", "simple_clip", "gsigndeneme28", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme29"] = {"ohgeesy@animation", "ohgeesy_clip", "gsigndeneme29", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme30"] = {"pastel3@animation", "pastel3_clip", "gsigndeneme30", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme31"] = {"pastelpose1@animation", "pastelpose1_clip", "gsigndeneme31", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme32"] = {"pasteldedos2@animation", "pasteldedos2_clip", "gsigndeneme32", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme33"] = {"lukitophoto2@animation", "lukitophoto2_clip", "gsigndeneme33", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme34"] = {"draco@arves", "draco_clip", "gsigndeneme34", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme35"] = {"wristcheck@animation", "wristcheck_clip", "gsigndeneme35", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme36"] = {"crossfinger@animation", "crossfinger_clip", "gsigndeneme36", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme37"] = {"seat1@animation", "seat1_clip", "gsigndeneme37", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme38"] = {"bag@animation", "bag_clip", "gsigndeneme38", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme39"] = {"five@nyck", "five_clip", "gsigndeneme39", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme40"] = {"capper@nyck", "capper_clip", "gsigndeneme40", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme41"] = {"pose@nyck", "pose_clip", "gsigndeneme41", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme42"] = {"pose2@nyck", "pose2_clip", "gsigndeneme42", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme43"] = {"pose3@nyck", "pose3_clip", "gsigndeneme43", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme44"] = {"mafiag@nyck", "mafiag_clip", "gsigndeneme44", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme45"] = {"15idk@animation", "15idk_clip", "gsigndeneme45", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme46"] = {"bkcr@animation", "bkcr_clip", "gsigndeneme46", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme47"] = {"bhw@animation", "bhw_clip", "gsigndeneme47", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme48"] = {"99mafia@animation", "99mafia_clip", "gsigndeneme48", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme49"] = {"krank@animation", "krank_clip", "gsigndeneme49", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme50"] = {"bangin@casual", "girl_clip", "gsigndeneme50", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme51"] = {"bangin@casual", "man_clip", "gsigndeneme51", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme52"] = {"hood@casual", "girl_clip", "gsigndeneme52", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme53"] = {"hood@casual", "male_clip", "gsigndeneme53", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme54"] = {"blooh@animation", "blooh_clip", "gsigndeneme54", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme55"] = {"famf@animation", "famf_clip", "gsigndeneme55", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme56"] = {"fuckb@animation", "fuckb_clip", "gsigndeneme56", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme57"] = {"grabber@animation", "grabber_clip", "gsigndeneme57", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme58"] = {"mfnapk@animation", "mfnapk_clip", "gsigndeneme58", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme59"] = {"neighbour@animation", "neighbour_clip", "gsigndeneme59", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme60"] = {"nonapps@animation", "nonapps_clip", "gsigndeneme60", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme61"] = {"zuna@animation", "zuna_clip", "gsigndeneme61", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme62"] = {"holdhip@animation", "holdhip_clip", "gsigndeneme62", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme63"] = {"holdhipb@animation", "holdhipb_clip", "gsigndeneme63", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme64"] = {"holdass@animation", "holdass_clip", "gsigndeneme64", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme65"] = {"holdassb@animation", "holdassb_clip", "gsigndeneme65", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme66"] = {"coupleseat1@animation", "coupleseat1_clip", "gsigndeneme66", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme67"] = {"coupleseat1b@animation", "coupleseat1b_clip", "gsigndeneme67", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme68"] = {"crshx@fix", "fix", "gsigndeneme68", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme69"] = {"crshx2@fix", "fix", "gsigndeneme69", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme70"] = {"mymsign1@animacion", "mymsign1_clip", "gsigndeneme70", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme71"] = {"mymsign20@animacion", "mymsign20_clip", "gsigndeneme71", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme72"] = {"mymsign30@animacion", "mymsign30_clip", "gsigndeneme72", AnimationOptions =
   {
       EmoteLoop = false,
   }},
   ["gsigndeneme73"] = {"chillimannn@animation", "chillimannn_clip", "gsigndeneme73", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme74"] = {"eastside@marisfreepack", "eastside", "gsigndeneme74", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme75"] = {"duoanim1@animation", "duoanim1_clip", "gsigndeneme75", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme76"] = {"hassanblood@animation", "hb_clip", "gsigndeneme76", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme77"] = {"bloodkiller@marisfreegpack", "bloodkiller", "gsigndeneme77", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme78"] = {"mafiacrip@marisfreegsignpack", "mafiacrip", "gsigndeneme78", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme79"] = {"cripkiller@marisgfreepack", "cripkiller", "gsigndeneme79", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme80"] = {"showback_naybahood@crip", "showback_naybahood", "gsigndeneme80", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme81"] = {"187@animation", "187", "gsigndeneme81", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme82"] = {"rollin60spose2@animation", "rollin60spose2", "gsigndeneme82", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme83"] = {"43_gangster@crip", "43_gangster", "gsigndeneme83", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme84"] = {"cripkiler@marisfreegsigns", "cripkiler", "gsigndeneme84", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme85"] = {"anim@60sv2", "60sv2_clip", "gsigndeneme85", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme86"] = {"anim@sixfingers", "six_clip", "gsigndeneme86", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme87"] = {"anim@nhtnh", "nhtnh_clip", "gsigndeneme87", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme88"] = {"anim@nayba", "nayba_clip", "gsigndeneme88", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme89"] = {"anim@fcktrays", "fcktrays_clip", "gsigndeneme89", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme90"] = {"anim@owe", "owe_clip", "gsigndeneme90", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme91"] = {"sensual1@casual", "girl_clip", "gsigndeneme91", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme92"] = {"sensual1@casual", "man_clip", "gsigndeneme92", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme93"] = {"ygzpose@animation", "dream_clip", "gsigndeneme93", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme94"] = {"downfingers@dreamdel", "dreamdel_clip", "gsigndeneme94", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme95"] = {"woopose@custom_anim", "woo_clip", "gsigndeneme95", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme96"] = {"sekposev3@animation", "v3", "gsigndeneme96", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme97"] = {"sekpose2v3@animation", "v3", "gsigndeneme97", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme98"] = {"sekpose2@animation", "clip", "gsigndeneme98", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme99"] = {"doubleo@animation", "doubleo_clip", "gsigndeneme99", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme100"] = {"missionary@casual", "girl_clip", "gsigndeneme100", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme101"] = {"missionary@casual", "man_clip", "gsigndeneme101", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme102"] = {"leangunanimation", "leangun_clip", "gsigndeneme102", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme103"] = {"whiskaspose1@stand", "whiskaspose1_makebywhiskas", "gsigndeneme103", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme104"] = {"whiskaspose2@stand", "whiskaspose2_makebywhiskas", "gsigndeneme104", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme105"] = {"whiskaspose3@stand", "whiskaspose3_makebywhiskas", "gsigndeneme105", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme106"] = {"holdracks@animation", "rackz_clip", "gsigndeneme106", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme107"] = {"customdeneme@anim", "customdeneme_clip", "gsigndeneme107", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme112"] = {"nhoneanimation", "nhone_clip", "gsigndeneme112", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme113"] = {"ceek2animation", "ceek2_clip", "gsigndeneme113", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme114"] = {"foek1animation", "foek1_clip", "gsigndeneme114", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme115"] = {"drillz@headtilt_anim", "headtilt_clip", "gsigndeneme115", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme116"] = {"drillz@laydown_anim", "laydown_clip", "gsigndeneme116", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme117"] = {"drillz@selfiewall_anim", "selfiewall_clip", "gsigndeneme117", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme118"] = {"drillz@leanfemalesit_anim", "leanfemalesit_clip", "gsigndeneme119", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme119"] = {"drillz@ruby_anim", "ruby_clip", "gsigndeneme119", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme120"] = {"posing1@animation", "posing1_clip", "gsigndeneme120", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme121"] = {"posing2@animation", "posing2_clip", "gsigndeneme121", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme122"] = {"posing3@animation", "posing3_clip", "gsigndeneme122", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme123"] = {"sureno@rabbit1", "rabbit_clip", "gsigndeneme123", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme124"] = {"sureno@thrtn", "thrtn_clip", "gsigndeneme124", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme125"] = {"ney3@animation", "ney_clip", "gsigndeneme125", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme126"] = {"rollz@walkpeace", "walkpeace_clip", "gsigndeneme126", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme127"] = {"ney@animation", "ney_clip", "gsigndeneme127", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme128"] = {"idleney@animation", "idle_clip", "gsigndeneme128", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme129"] = {"leanwoface@animation", "lean_clip", "gsigndeneme129", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme130"] = {"esse@drakowall", "drakowall_clip", "gsigndeneme130", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme131"] = {"nbn@animation", "nbn_clip", "gsigndeneme131", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme132"] = {"wrldmods@trippieredd", "trippieredd", "gsigndeneme132", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme133"] = {"lunyx@random001", "random001", "gsigndeneme133", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme134"] = {"lunyx@random002", "random002", "gsigndeneme134", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme135"] = {"lunyx@random003", "random003", "gsigndeneme135", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme136"] = {"leanganglit@animation", "leanganglit_clip", "gsigndeneme136", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme137"] = {"shlass@animation", "shlass_clip", "gsigndeneme137", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme138"] = {"gangsign1@animation", "gangsign1_clip", "gsigndeneme138", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme139"] = {"doublec@animation", "doublec_clip", "gsigndeneme139", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme140"] = {"handsup@animation", "handsup_clip", "gsigndeneme140", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme141"] = {"holdhands@anim", "holdhands_clip", "gsigndeneme141", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme142"] = {"syx@kiss02a", "kiss02a", "gsigndeneme142", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme143"] = {"syx@kiss02b", "kiss02b", "gsigndeneme143", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme144"] = {"syx@cute01", "cute01", "gsigndeneme144", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme145"] = {"syx@cute02", "cute02", "gsigndeneme145", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme146"] = {"syx@cute03", "cute03", "gsigndeneme146", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme147"] = {"syx@cute04", "cute04", "gsigndeneme147", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme148"] = {"syx@cute05", "cute05", "gsigndeneme148", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme149"] = {"lunyx@rgmp01", "rgmp01", "gsigndeneme149", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme150"] = {"lunyx@rgmp02", "rgmp02", "gsigndeneme150", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme151"] = {"lunyx@rgmp03", "rgmp03", "gsigndeneme151", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme152"] = {"lunyx@rgmp06", "rgmp06", "gsigndeneme152", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme153"] = {"lunyx@rgmp07", "rgmp07", "gsigndeneme153", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme154"] = {"gdkanimationanimation", "gdkanimation_clip", "gsigndeneme154", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme155"] = {"moneyspread1@animation", "moneyspread1_clip", "gsigndeneme155", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme156"] = {"divined@rpack@new", "alchemy", "gsigndeneme156", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme157"] = {"divined@rpack@new", "badmood", "gsigndeneme157", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme158"] = {"divined@rpack@new", "bunnyhop", "gsigndeneme158", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme159"] = {"divined@rpack@new", "burpee", "gsigndeneme159", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme160"] = {"divined@rpack@new", "callme", "gsigndeneme160", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme161"] = {"divined@rpack@new", "coronet", "gsigndeneme161", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme162"] = {"divined@rpack@new", "dcry", "gsigndeneme162", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme163"] = {"divined@rpack@new", "hailcab", "gsigndeneme163", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme164"] = {"divined@rpack@new", "kepler", "gsigndeneme164", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme165"] = {"divined@rpack@new", "mindblown", "gsigndeneme165", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme166"] = {"divined@rpack@new", "uproar", "gsigndeneme166", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme167"] = {"divined@rpack@new", "yeet", "gsigndeneme167", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme168"] = {"rollz@twofingers", "twofingers_clip", "gsigndeneme168", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme169"] = {"rollz@leanmiddle", "leanmiddle_clip", "gsigndeneme169", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme170"] = {"anim@playboyig", "playboy_clip", "gsigndeneme170", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme171"] = {"anim@doublerabbit", "rabbit_clip", "gsigndeneme171", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme172"] = {"nhcanimation", "nhc_clip", "gsigndeneme172", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme173"] = {"gangisgn1animation", "gangisgn1_clip", "gsigndeneme173", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme174"] = {"gangsign2animation", "gangsign2_clip", "gsigndeneme174", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme175"] = {"drillz@femalefuckoff_anim", "fuckoff_clip", "gsigndeneme175", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme176"] = {"drillz@fucktheopps_anim", "fucktheopps_clip", "gsigndeneme176", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme177"] = {"drillz@fuckyou_anim", "fuckyou_clip", "gsigndeneme177", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme178"] = {"drillz@oneleg_anim", "oneleg_clip", "gsigndeneme178", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme179"] = {"drillz@thebirdfemale_anim", "thebird_clip", "gsigndeneme179", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme180"] = {"f13ganganimation", "f13gang_clip", "gsigndeneme180", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme181"] = {"cosmocrippah", "crippah_clip", "gsigndeneme181", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme182"] = {"anim@sureno", "sureno_clip", "gsigndeneme182", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme183"] = {"anim@guttagang", "gutta_clip", "gsigndeneme183", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["gsigndeneme184"] = {"anim@fog_rifle_relaxed", "rifle_relaxed_clip", "gsigndeneme184", AnimationOptions =
   {
	   EmoteLoop = true,
	   EmoteMoving = false,
   }},
   ["gsigndeneme185"] = {"anim@stack_pointman", "pointman_clip", "gsigndeneme185", AnimationOptions =
   {
	   EmoteLoop = true,
	   EmoteMoving = false,
   }},
   ["gsigndeneme186"] = {"anim@stack_two_man", "two_man_clip", "gsigndeneme186", AnimationOptions =
   {
	   EmoteLoop = true,
	   EmoteMoving = false,
   }},
   ["gsigndeneme187"] = {"anim@stack_three_man", "three_man_clip", "gsigndeneme187", AnimationOptions =
   {
	   EmoteLoop = true,
	   EmoteMoving = false,
   }},
   ["gsigndeneme188"] = {"anim@highlow_low_lean", "low_lean_clip", "gsigndeneme188", AnimationOptions =
   {
	   EmoteLoop = true,
	   EmoteMoving = false,
   }},
   ["gsigndeneme189"] = {"anim@highlow_high_lean", "high_lean_clip", "gsigndeneme189", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme190"] = {"anim@gang_pistol_westside", "pistol_westside_clip", "gsigndeneme190", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme191"] = {"anim@gang_one", "gang_one_clip", "gsigndeneme191", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme192"] = {"anim@gang_two", "gang_two_clip", "gsigndeneme192", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme193"] = {"anim@model_car_fancy", "car_fancy_clip", "gsigndeneme193", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme194"] = {"anim@model_stretched_leg", "stretched_leg_clip", "gsigndeneme194", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme195"] = {"anim@car_sitting_fuckyou", "sitting_fuckyou_clip", "gsigndeneme195", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme196"] = {"anim@car_sitting_cute", "sitting_cute_clip", "gsigndeneme196", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme197"] = {"anim@model_bike", "bike_clip", "gsigndeneme197", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme198"] = {"anim@model_bike_two", "bike_two_clip", "gsigndeneme198", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme199"] = {"anim@peace_selfie", "peace_clip", "gsigndeneme199", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme200"] = {"anim@stance_folded_arms", "folded_arms_clip", "gsigndeneme200", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme201"] = {"anim@stance_kneeling_cute", "kneeling_cute_clip", "gsigndeneme201", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme202"] = {"anim@sit_cute_window", "cute_window_clip", "gsigndeneme202", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme203"] = {"anim@car_cute_sit", "cute_sit_clip", "gsigndeneme203", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme204"] = {"anim@selfie_peacesign_cute", "peacesign_cute_clip", "gsigndeneme204", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme205"] = {"anim@female_smoke_01", "f_smoke_01_clip", "gsigndeneme205", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme206"] = {"anim@female_lean_01", "f_lean_01_clip", "gsigndeneme206", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme207"] = {"anim@female_selfie_1st_01", "f_selfie_1st_01_clip", "gsigndeneme207", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme208"] = {"anim@female_model_01", "f_model_01_clip", "gsigndeneme208", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme209"] = {"anim@female_model_02", "f_model_02_clip", "gsigndeneme209", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme210"] = {"anim@female_model_03", "f_model_03_clip", "gsigndeneme210", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme211"] = {"anim@selfie_knees_cute", "knees_cute_clip", "gsigndeneme211", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme212"] = {"anim@sw_sit_chill", "sit_chill_clip", "gsigndeneme212", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme213"] = {"anim@sw_chill_pose", "chill_pose_clip", "gsigndeneme213", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme214"] = {"anim@stance_handgun", "handgun_clip", "gsigndeneme214", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme215"] = {"anim@stance_handgun", "handgun_clip", "gsigndeneme215", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = true,
   }},
   ["gsigndeneme216"] = {"anim@shooter_stance", "stance_clip", "gsigndeneme216", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme217"] = {"anim@shooter_stance", "stance_clip", "gsigndeneme217", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = true,
   }},
   ["gsigndeneme218"] = {"thot_pose", "thot_clip", "gsigndeneme218", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme219"] = {"anim@fuck_you_selfie", "fuck_you_selfie_clip", "gsigndeneme219", AnimationOptions =
   {
	  EmoteLoop = true,
	  EmoteMoving = false,
   }},
   ["gsigndeneme220"] = {"lunyx@random@v3@pose001", "random@v3@pose001", "gsigndeneme220", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme221"] = {"lunyx@random@v3@pose002", "random@v3@pose002", "gsigndeneme221", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme222"] = {"lunyx@random@v3@pose003", "random@v3@pose003", "gsigndeneme222", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme223"] = {"lunyx@random@v3@pose004", "random@v3@pose004", "gsigndeneme223", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme224"] = {"lunyx@random@v3@pose005", "random@v3@pose005", "gsigndeneme224", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme225"] = {"lunyx@random@v3@pose006", "random@v3@pose006", "gsigndeneme225", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme226"] = {"lunyx@random@v3@pose007", "random@v3@pose007", "gsigndeneme226", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   
   ["gsigndeneme227"] = {"lunyx@random@v3@pose008", "random@v3@pose008", "gsigndeneme227", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme228"] = {"lunyx@random@v3@pose009", "random@v3@pose009", "gsigndeneme228", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme229"] = {"lunyx@random@v3@pose010", "random@v3@pose010", "gsigndeneme229", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme230"] = {"lunyx@random@v3@pose011", "random@v3@pose011", "gsigndeneme230", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme231"] = {"lunyx@random@v3@pose012", "random@v3@pose012", "gsigndeneme231", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme232"] = {"lunyx@random@v3@pose013", "random@v3@pose013", "gsigndeneme232", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme233"] = {"lunyx@random@v3@pose014", "random@v3@pose014", "gsigndeneme233", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme234"] = {"lunyx@random@v3@pose015", "random@v3@pose015", "gsigndeneme234", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme235"] = {"lunyx@random@v3@pose016", "random@v3@pose016", "gsigndeneme235", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme236"] = {"lunyx@random@v3@pose017", "random@v3@pose017", "gsigndeneme236", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme237"] = {"lunyx@random@v3@pose018", "random@v3@pose018", "gsigndeneme237", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme238"] = {"lunyx@random@v3@pose019", "random@v3@pose019", "gsigndeneme238", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme239"] = {"lunyx@random@v3@pose020", "random@v3@pose020", "gsigndeneme239", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme240"] = {"testanim@alina", "testanim_clip", "gsigndeneme240", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme241"] = {"hoe@anim", "hoe_clip", "gsigndeneme241", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme242"] = {"hoe2@anim", "hoe2_clip", "gsigndeneme242", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme243"] = {"expertmode@anim", "expertmode_clip", "gsigndeneme243", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme244"] = {"pose1@anim", "pose1_clip", "gsigndeneme244", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme245"] = {"expertmode2@anim", "expertmode2_clip", "gsigndeneme245", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme246"] = {"1foot@anim", "1foot_clip", "gsigndeneme246", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme247"] = {"car1@anim", "car1_clip", "gsigndeneme247", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme248"] = {"car2@anim", "car2_clip", "gsigndeneme248", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme249"] = {"selfie@anim", "selfie_clip", "gsigndeneme249", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme250"] = {"selfie2@anim", "selfie2_clip", "gsigndeneme250", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme251"] = {"randompose1@anim", "randompose1_clip", "gsigndeneme251", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme252"] = {"randompose2@anim", "randompose2_clip", "gsigndeneme252", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme253"] = {"stripper1@anim", "stripper1_clip", "gsigndeneme253", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme254"] = {"strip2@anim", "strip2_clip", "gsigndeneme254", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme255"] = {"pose5@anim", "pose5_clip", "gsigndeneme255", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme256"] = {"slavepose@anim", "slavepose_clip", "gsigndeneme256", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme257"] = {"gangsign50@animation", "gangsign50_clip", "gsigndeneme257", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme258"] = {"stanleylebougla@animation", "stanleylebougla_clip", "gsigndeneme258", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme259"] = {"217aim2xanimation", "aim2x_clip", "gsigndeneme259", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme260"] = {"dollie_mods@follow_me_001", "follow_me_001", "gsigndeneme260", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme261"] = {"dollie_mods@follow_me_002", "follow_me_002", "gsigndeneme261", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme262"] = {"tattooshowinn@animation", "tattooshowinn_clip", "gsigndeneme262", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme263"] = {"amb@world_human_hang_out_street@male_a@base", "base", "gsigndeneme263", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme264"] = {"amb@world_human_hang_out_street@male_a@enter", "enter", "gsigndeneme264", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme265"] = {"amb@world_human_hang_out_street@male_a@exit", "exit", "gsigndeneme265", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme256"] = {"amb@world_human_hang_out_street@male_a@idle_a", "idle_a", "gsigndeneme266", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme267"] = {"amb@world_human_hang_out_street@male_a@idle_a", "idle_b", "gsigndeneme267", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme268"] = {"amb@world_human_hang_out_street@male_a@idle_a", "idle_c", "gsigndeneme268", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme269"] = {"amb@world_human_hang_out_street@male_a@idle_a", "idle_d", "gsigndeneme269", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme270"] = {"amb@world_human_hang_out_street@male_b@base", "base", "gsigndeneme270", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme271"] = {"amb@world_human_hang_out_street@male_b@enter", "enter", "gsigndeneme271", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme272"] = {"amb@world_human_hang_out_street@male_b@exit", "exit", "gsigndeneme272", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme273"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_a", "gsigndeneme273", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme274"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "gsigndeneme274", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme275"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_c", "gsigndeneme275", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme276"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_d", "gsigndeneme276", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme277"] = {"amb@world_human_hang_out_street@male_c@base", "base", "gsigndeneme277", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme278"] = {"amb@world_human_hang_out_street@male_c@enter", "enter", "gsigndeneme278", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme279"] = {"amb@world_human_hang_out_street@male_c@exit", "exit", "gsigndeneme279", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme280"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_a", "gsigndeneme280", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme281"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "gsigndeneme281", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme282"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_c", "gsigndeneme282", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme283"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_d", "gsigndeneme283", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme284"] = {"amb@world_human_hang_out_street@female_arm_side@base", "base", "gsigndeneme284", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme285"] = {"amb@world_human_hang_out_street@female_arm_side@enter", "enter", "gsigndeneme285", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme286"] = {"amb@world_human_hang_out_street@female_arm_side@exit", "exit", "gsigndeneme286", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme287"] = {"amb@world_human_hang_out_street@female_arm_side@idle_a", "idle_a", "gsigndeneme287", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme288"] = {"amb@world_human_hang_out_street@female_arm_side@idle_a", "idle_b", "gsigndeneme288", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme289"] = {"amb@world_human_hang_out_street@female_arm_side@idle_a", "idle_c", "gsigndeneme289", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme290"] = {"amb@world_human_hang_out_street@female_arm_side@idle_a", "idle_d", "gsigndeneme290", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme291"] = {"amb@world_human_hang_out_street@female_arms_crossed@base", "base", "gsigndeneme291", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme292"] = {"amb@world_human_hang_out_street@female_arms_crossed@enter", "enter", "gsigndeneme292", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme293"] = {"amb@world_human_hang_out_street@female_arms_crossed@exit", "exit", "gsigndeneme293", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme294"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "gsigndeneme294", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme295"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_b", "gsigndeneme295", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme296"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_c", "gsigndeneme296", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme297"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_d", "gsigndeneme297", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme298"] = {"amb@world_human_hang_out_street@female_hold_arm@base", "base", "gsigndeneme298", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme299"] = {"amb@world_human_hang_out_street@female_hold_arm@enter", "enter", "gsigndeneme299", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme300"] = {"amb@world_human_hang_out_street@female_hold_arm@exit", "exit", "gsigndeneme300", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme301"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "gsigndeneme301", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme302"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_b", "gsigndeneme302", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme303"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_c", "gsigndeneme303", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme304"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_d", "gsigndeneme304", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme305"] = {"betrex@sunglasses", "glasses", "gsigndeneme305", AnimationOptions =
   {
       EmoteLoop = false,
   }},
   ["gsigndeneme306"] = {"chouko@freeheart", "freeheart", "gsigndeneme306", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme307"] = {"chouko@nailpose", "nailpose", "gsigndeneme307", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme308"] = {"chid@nyck", "chid_clip", "gsigndeneme308", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme309"] = {"move_m@generic_idles@std", "idle_a", "gsigndeneme309", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme310"] = {"move_m@generic_idles@std", "idle_b", "gsigndeneme310", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme311"] = {"move_m@generic_idles@std", "idle_c", "gsigndeneme311", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme312"] = {"move_m@generic_idles@std", "idle_d", "gsigndeneme312", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme313"] = {"nhyza1@animation", "nhyza1_clip", "gsigndeneme313", AnimationOptions =
   {
       EmoteLoop = false,
   }},
   ["gsigndeneme314"] = {"qpacc@gangsign1", "gangsign1_clip", "gsigndeneme314", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme315"] = {"qpacc@gangsign2", "gangsign2_clip", "gsigndeneme315", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme316"] = {"qpacc@gangsign3", "gangsign3_clip", "gsigndeneme316", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme317"] = {"qpacc@gangsign4", "gangsign4_clip", "gsigndeneme317", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme318"] = {"qpacc@gangsign5", "gangsign5_clip", "gsigndeneme318", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme319"] = {"qpacc@gangsign6", "gangsign6_clip", "gsigndeneme319", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme320"] = {"qpacc@gangsign7", "gangsign7_clip", "gsigndeneme320", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme321"] = {"qpacc@gangsign8", "gangsign8_clip", "gsigndeneme321", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme322"] = {"mymsign25@animacion", "mymsign25_clip", "gsigndeneme322", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme323"] = {"mymsign67@animacion", "mymsign67_clip", "gsigndeneme323", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme324"] = {"cast@sign1@animation", "cast@sign1_clip", "gsigndeneme324", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme325"] = {"cast@sign2@animation", "cast@sign2_clip", "gsigndeneme325", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme326"] = {"crip@animation", "crip_clip", "gsigndeneme326", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme327"] = {"handoverffacefinger@sign@animation", "handoverffacefinger@sign_clip", "gsigndeneme327", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme328"] = {"bendover@sign@animation", "bendover@sign_clip", "gsigndeneme328", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme329"] = {"whitepower@animation", "whitepower_clip", "gsigndeneme329", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme330"] = {"standhand2animation", "standhand2_clip", "gsigndeneme330", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme331"] = {"standhand2@animation", "standhand2_clip", "gsigndeneme331", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme332"] = {"tidselfie01@animation", "tidselfie01_clip", "gsigndeneme332", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme333"] = {"mggyhang1@animation", "mggyhang1_clip", "gsigndeneme333", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme334"] = {"mggyhang2@animation", "mggyhang2_clip", "gsigndeneme334", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme335"] = {"mggyhang3@animation", "mggyhang3_clip", "gsigndeneme335", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme336"] = {"mggypiggypair1@animation", "mggypiggypair1_clip", "gsigndeneme336", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme337"] = {"mggypiggypair2@animation", "mggypiggypair2_clip", "gsigndeneme337", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme338"] = {"mggyselfie1@animation", "mggyselfie1_clip", "gsigndeneme338", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme339"] = {"mggyselfie2@animation", "mggyselfie2_clip", "gsigndeneme339", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme340"] = {"mggyselfie4@animation", "mggyselfie4_clip", "gsigndeneme340", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme341"] = {"custom@animation", "sitting_clip", "gsigndeneme341", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme342"] = {"slave@mchmnk", "slave_clip", "gsigndeneme342", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme343"] = {"mistress@mchmnk", "mistress_clip", "gsigndeneme343", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme344"] = {"coupleero01fr@mchmnk", "coupleero01fr_clip", "gsigndeneme344", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme345"] = {"coupleero01tw@mchmnk", "coupleero01tw_clip", "gsigndeneme345", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme346"] = {"waitingfordaddy@mchmnk", "waitingfordaddy_clip", "gsigndeneme346", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme347"] = {"tidsitting07@animation", "tidsitting07_clip", "gsigndeneme347", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme348"] = {"tidstanding11@animation", "tidstanding11_clip", "gsigndeneme348", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme349"] = {"tidstanding14@animation", "tidstanding14_clip", "gsigndeneme349", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme350"] = {"tidstanding15@animation", "tidstanding15_clip", "gsigndeneme350", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme351"] = {"tidstandingselfie11@animation", "tidstandingselfie11_clip", "gsigndeneme351", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme352"] = {"tidstandingselfie12@animation", "tidstandingselfie12_clip", "gsigndeneme352", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme353"] = {"christiandior@animation", "christiandior_clip", "gsigndeneme353", AnimationOptions =
   {
    Prop = 'p_ld_heist_bag_s_2',
    PropBone = 24817,
    PropPlacement = {-0.75, 0.18, -0.016, 180.0, -90.0, 90.0},
    EmoteMoving = false,
    EmoteLoop = true
   }},
   ["gsigndeneme354"] = {"christiandior2@animation", "christiandior2_clip", "gsigndeneme354", AnimationOptions =
   {
       Prop = "p_ld_heist_bag_s_2",
       PropBone = 57005,
       PropPlacement = {-0.335, -0.345, 0.245, 300.0, 180.0, 30.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gsigndeneme355"] = {"christiandior2@animation", "christiandior2_clip", "gsigndeneme355", AnimationOptions =
   {
       Prop = "p_ld_heist_bag_s_2",
       PropBone = 57005,
       PropPlacement = {-0.335, -0.345, 0.245, 300.0, 180.0, 30.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gsigndeneme356"] = {"longokillaanimation", "longokilla_clip", "gsigndeneme356", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme357"] = {"cas2animation", "cas2_clip", "gsigndeneme357", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme358"] = {"salutepose@animation", "salutepose_clip", "gsigndeneme358", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme359"] = {"sheshanimation", "shesh_clip", "gsigndeneme359", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme360"] = {"crouchinganimation", "crouching_clip", "gsigndeneme360", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme361"] = {"femalepose6@animation", "femalepose6_clip", "gsigndeneme361", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme362"] = {"femalepose5@animation", "femalepose5_clip", "gsigndeneme362", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme363"] = {"freeanim1animation", "freeanim1_clip", "gsigndeneme363", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme364"] = {"freeanim2animation", "freeanim2_clip", "gsigndeneme364", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme365"] = {"mggycas2@animation", "mggycas2_clip", "gsigndeneme365", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme366"] = {"mggycas1@animation", "mggycas1_clip", "gsigndeneme366", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme367"] = {"mggymirror4@animation", "mggymirror4_clip", "gsigndeneme367", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme368"] = {"mggymirror3@animation", "mggymirror3_clip", "gsigndeneme368", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme369"] = {"mggymirror2@animation", "mggymirror2_clip", "gsigndeneme369", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme370"] = {"mggymirror1@animation", "mggymirror1_clip", "gsigndeneme370", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme371"] = {"bfflookback1@animation", "bfflookback1_clip", "gsigndeneme371", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme372"] = {"bfflookback2@animation", "bfflookback2_clip", "gsigndeneme372", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme373"] = {"bffcasualpose1@animation", "bffcasualpose1_clip", "gsigndeneme373", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme374"] = {"bffcasualpose2@animation", "bffcasualpose2_clip", "gsigndeneme374", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme375"] = {"bfffun1@animation", "bfffun1_clip", "gsigndeneme375", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme376"] = {"bfffun2@animation", "bfffun2_clip", "gsigndeneme376", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme377"] = {"bffhandhold1@animation", "bffhandhold1_clip", "gsigndeneme377", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme378"] = {"bffhandhold2@animation", "bffhandhold2_clip", "gsigndeneme378", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme379"] = {"mggycouplehug1@animation", "mggycouplehug1_clip", "gsigndeneme379", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme380"] = {"mggycouplehug2@animation", "mggycouplehug2_clip", "gsigndeneme380", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gsigndeneme381"] = {"mggycouplehugphone@animation", "mggycouplehugphone_clip", "gsigndeneme381", AnimationOptions =
   {
       EmoteLoop = true,
   }},
    ["handspocket"] = {"custom@handsinpockets_1", "handsinpockets_1", "Main dans les poches", AnimationOptions =
    {
       EmoteMoving = true,
       EmoteLoop = true,
    }},
    ["sittingselfie"] = {"anim@sitting_thot", "sitting_thot_clip", "Pose insta #1 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = false,
        EmoteMoving = false,
    }},
    ["leanwallmodel"] = {"anim@model_wall_cute", "wall_cute_clip", "Pose insta #2 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["kneelstare1"] = {"anim@kneeling_stare", "kneeling_stare_clip", "Pose insta #3 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["gunselfie1"] = {"anim@hoodrat_pistol_selfie", "selfie_clip", "Pose insta #4 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["floorselfie1"] = {"anim@selfie_floor_cute", "floor_cute_clip", "Pose insta #5 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["modelshy"] = {"anim@model_cute", "model_cute_clip", "Pose insta #6 ~r~<3~s~", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
            



   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Les mains sur le comptoir", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Grose sieste"},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Allongé relax", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Vérifier la liste"},
   ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Allongé dos au sol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Allongé dos au sol détendu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Les mains sur la ceinture"},
   ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Flic bras croisé", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "flic appel radio", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Croiser les bras", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Croiser les bras en s'expriment", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Croiser les bras d'un air sérieux", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Croiser les bras main visible", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Croiser les bras énervé", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms6"] = {"random@shop_gunstore", "_idle", "Croiser les bras pour danse russe", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Croiser les bras avec la tête sur le côté", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Dormir debout", AnimationOptions =
   	{
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Croisez les bras en mode videur", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Croisez les bras énervé 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Pose de videur"},
   ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Attendre un client"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Tsheck gangster"},

   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Se regarder dans le miroir", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle1"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Se regarder dans le miroir 1"},
   ["idle2"] = {"friends@fra@ig_1", "base_idle", "Se regarder dans le miroir 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"mp_move@prostitute@m@french", "idle", "Se regarder dans le miroir 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["idle4"] = {"random@countrysiderobbery", "idle_a", "Se regarder dans le miroir 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Se regarder dans le miroir 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Se regarder dans le miroir 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Se regarder dans le miroir 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Se regarder dans le miroir 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle9"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Se regarder dans le miroir 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Se regarder dans le miroir 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Bourré sur place", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Bourré sur place 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Bourré sur place 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["kneel2"] = {"rcmextreme3", "idle", "S'agenouiller", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "S'agenouiller avec le bras sur le genou", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Attendre posé contre un mur"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Poser sur le mur en fumant", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pose4"] = {"custom@male_pose_1", "male_pose_1", "Pose 4", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["pose5"] = {"custom@male_pose_2", "male_pose_2", "Pose 5", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["pose6"] = {"custom@male_pose_3", "male_pose_3", "Pose 6", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Poser sur le mur détendu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Poser sur le mur mains croisés", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pose1"] = {"custom@female_pose_1", "female_pose_1", "Pose 1", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["pose2"] = {"custom@female_pose_2", "female_pose_2", "Pose 2", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["pose3"] = {"custom@female_pose_3", "female_pose_3", "Pose 3", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Attendre posé sur un bar"},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "S'appuyer sur un bar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "S'appuyer sur un bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "S'appuyer sur un bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Tenir ses genoux", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Pousser un caddie", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Pousser un caddie 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside"] = {"timetable@mime@01_gc", "idle_a", "S'accrocher sur le côtés", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "S'accrocher sur le côtés 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "S'accrocher sur le côtés 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "S'accrocher sur le côtés 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["prone"] = {"missfbi3_sniping", "prone_dave", "S'allonger à plat ventre", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Dormir", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Prendre un bain de soleil"},
   ["surrender"] = {"random@arrests@busted", "idle_a", "Se rendre", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Faire la statue"},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Faire la statue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Faire la statue 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Bronzer sur le dos", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Bronzer sur le dos", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", " Bronzer sur le ventre"},
   ["t"] = {"missfam5_yoga", "a2_pose", "Faire le T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "Faire le T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait"] = {"random@shop_tattoo", "_idle_a", "Attendre", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Attendre 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Attendre 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Attendre 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Attendre 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Attendre 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Attendre 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Attendre 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Attendre 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["waitt10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Attendre 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["waitt11"] = {"misshair_shop@hair_dressers", "keeper_base", "Attendre 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["waitt12"] = {"rcmjosh1", "idle", "Attendre 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["waitt13"] = {"rcmnigel1a", "base", "Attendre 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}

DP.Sports = {
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Entraînement de boxe", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Entraînement de boxe 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Faire des tractions"},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Se mettre en position de combat"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "S'étirer avant un combat"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Salto"},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Demi salto"},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Jouer au golf"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "S'échauffer pour son jogging"},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Faire son jogging", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Faire son jogging étant heureux", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Faire son jogging avec les bras tendu", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Faire son jogging comme un robot", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Faire des sauts de sport", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Faire du karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Faire du karate 2"},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Fatigué après une course", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Tapé dans le ventre", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Faire des pompes", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Faire des abdos", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Glissade sur les genoux"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Glissade sur les genoux 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Glissade sur les genoux 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Tir à la bate"},
   ["stretch"] = {"mini@triathlon", "idle_e", "S'échauffer en s'étirant", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "S'échauffer en s'étirant 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "S'échauffer en s'étirant 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "S'échauffer en s'étirant 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Faire du yoga"},
}

DP.Santes = {
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Massage cardiaque au sol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Massage cardiaque sur une table", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Ramper au sol blessé", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Médecin inspectant une personne"},
   ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Médecin inspectant un blessé", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout"] = {"missarmenian2", "drunk_loop", "Perdre connaissance", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Perdre connaissance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Perdre connaissance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Perdre connaissance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Perdre connaissance 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Blesser par balle au sol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
}
