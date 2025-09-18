// PUT ON STEP EVENT

if (obj_pc1.key_int1_press==1) && (distance_to_object(obj_pc1)<=range) 
        {
        txtbox = 1;
        }


if (txtbox<>0) && (distance_to_object(obj_pc1)>range)
    {
    txtbox = 0;
    }

// END STEP EVENT
