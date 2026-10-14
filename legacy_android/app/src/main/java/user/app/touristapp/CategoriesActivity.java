package user.app.touristapp;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;
import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;

public class CategoriesActivity extends AppCompatActivity
{
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_categories);

        TabLayout tabLayout =  findViewById(R.id.tabLayout);
        ViewPager2 viewPager = findViewById(R.id.viewPager);

        TouristPagerAdapter adapter = new TouristPagerAdapter(this);
        viewPager.setAdapter(adapter);

        new TabLayoutMediator(tabLayout, viewPager, (tab, position) ->
        {
            switch (position)
            {
                case 0 :
                    tab.setText("Food");
                break;

                case 1 :
                    tab.setText("Nightlife");
                break;

                case 2 :
                    tab.setText("Things To Do");
                    break;

                case 3 :
                    tab.setText("Places To See");
                    break;
            }

        }).attach();
    }

}