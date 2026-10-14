package user.app.touristapp;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager2.adapter.FragmentStateAdapter;

public class TouristPagerAdapter extends FragmentStateAdapter
{
    public TouristPagerAdapter(@NonNull FragmentActivity fragmentActivity)
    {
        super(fragmentActivity);
    }

    @Override
    @NonNull
    public Fragment createFragment(int position)
    {
        switch (position)
        {
            case 0 : return new FoodFragment();
            case 1 : return new NightlifeFragment();
            case 2 : return  new ThingsToDoFragment();
            case 3 : return new PlacesToSeeFragment();
            default: return new FoodFragment();
        }
    }

    @Override
    public int getItemCount() {
        return 4;
    }
}
